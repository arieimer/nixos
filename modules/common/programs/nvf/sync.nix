notesDir: {
  pkgs,
  lib,
  ...
}: {
  vim.extraPackages = [pkgs.git pkgs.openssh];

  vim.luaConfigRC.notes-sync = lib.nvim.dag.entryAnywhere ''
    vim.o.autoread = true

    local dir = (vim.fn.expand(vim.env.NOTES_DIR or "${notesDir}"):gsub("/+$", ""))
    local prefix = dir .. "/"

    local rebase = [[
      rebase() {
        git pull --rebase --autostash -q || { git rebase --abort 2>/dev/null; exit 1; }
      }
    ]]
    local scripts = {
      pull = rebase .. "rebase",
      push = rebase .. [[
        git add -A
        git diff --cached --quiet || git commit -q -m "sync: $(uname -n) $(date -Iseconds)"
        rebase
        git push -q
      ]],
    }

    -- Serialize runs; a save during a running sync queues one follow-up push
    local busy, again = false, false
    local function run(mode, cb)
      if busy then
        if mode == "push" then again = true end
        return
      end
      busy = true
      vim.system({ "sh", "-c", scripts[mode] }, { cwd = dir, text = true }, function(res)
        vim.schedule(function()
          busy = false
          if res.code ~= 0 then
            vim.notify("notes-sync " .. mode .. " failed: " .. (res.stderr or ""), vim.log.levels.WARN)
          end
          if cb then cb() end
          if again then again = false; run("push") end
        end)
      end)
    end

    local function in_notes(file)
      local p = vim.fn.fnamemodify(file, ":p")
      return p:sub(1, #prefix) == prefix and not p:find("/.git/", 1, true)
    end

    -- Path used to decide whether an event is relevant
    local function target(args)
      if args.event == "BufReadPost" then return args.file end
      local name = vim.api.nvim_buf_get_name(0)
      if name == "" then name = vim.fn.getcwd() .. "/" end
      return name
    end

    local group = vim.api.nvim_create_augroup("NotesSync", { clear = true })
    local last_pull = -math.huge

    -- Pull on session start, file open, and terminal focus (throttled to 60 s)
    vim.api.nvim_create_autocmd({ "VimEnter", "BufReadPost", "FocusGained" }, {
      group = group,
      callback = function(args)
        if not in_notes(target(args)) then return end
        local now = vim.uv.now()
        if now - last_pull < 60000 then return end
        last_pull = now
        run("pull", function() vim.cmd("silent! checktime") end)
      end,
    })

    -- Commit, rebase, and push on save
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = group,
      pattern = "*.norg",
      callback = function(args)
        if in_notes(args.file) then run("push") end
      end,
    })
  '';
}
