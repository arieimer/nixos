{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf types mkOption;
  cfg = config.cfg.programs.nvf;
in {
  options.cfg.programs.nvf = {
    enable = mkEnableOption "nvf";
    notesDir = mkOption {
      type = types.str;
      default = "/home/${config.cfg.user.username}/Documents/notes";
    };
  };
  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      defaultEditor = true;
      settings = {
        imports = [
          (import ./sync.nix config.cfg.programs.nvf.notesDir)
        ];
        vim = {
          viAlias = true;
          vimAlias = true;
          keymaps = [
            {
              key = "<leader>gf";
              mode = "n";
              action = "<cmd>Neotree toggle<CR>";
              silent = true;
              desc = "Toggle Neo-tree";
            }
            {
              key = "<leader>ff";
              mode = "n";
              action = "<cmd>Telescope find_files<CR>";
              silent = true;
              desc = "Find files";
            }
            {
              key = "<leader>fg";
              mode = "n";
              action = "<cmd>Telescope live_grep<CR>";
              silent = true;
              desc = "Search text";
            }
            {
              key = "<leader>fb";
              mode = "n";
              action = "<cmd>Telescope buffers<CR>";
              silent = true;
              desc = "Find buffers";
            }
            {
              key = "<leader>bd";
              mode = "n";
              action = "<cmd>bd<CR>";
              silent = true;
              desc = "Close buffer";
            }
            {
              key = "<C-c>";
              mode = "n";
              action = "gcc";
              noremap = false;
              silent = true;
              desc = "Toggle line comment";
            }
            {
              key = "<C-c>";
              mode = "v";
              action = "gc";
              noremap = false;
              silent = true;
              desc = "Toggle comment on selection";
            }
            {
              key = "<Esc>";
              mode = "n";
              action = "<cmd>nohlsearch<CR>";
              silent = true;
              desc = "hides text left behind search easily";
            }
            {
              mode = "n";
              key = "<leader>ni";
              action = "<cmd>Neorg index<CR>";
              desc = "Open notes index";
            }
            {
              mode = "n";
              key = "<leader>nr";
              action = "<cmd>Neorg toggle-concealer<CR>";
              desc = "Toggle render";
            }
            {
              mode = "n";
              key = "<leader>nf";
              action = "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('${config.cfg.programs.nvf.notesDir}') })<CR>";
              desc = "Find notes";
            }
            {
              mode = "n";
              key = "<leader>nl";
              action = "<Plug>(neorg.telescope.insert_file_link)";
              desc = "Insert note link";
            }
            {
              mode = "n";
              key = "<leader>nti";
              action = "<cmd>0read ${./templates/root-index.norg} | silent $delete _ | normal! gg<CR>";
              desc = "Template: root index";
            }
            {
              mode = "n";
              key = "<leader>nta";
              action = "<cmd>0read ${./templates/area-index.norg} | silent $delete _ | normal! gg<CR>";
              desc = "Template: area index";
            }
            {
              mode = "n";
              key = "<leader>ntn";
              action = "<cmd>0read ${./templates/note.norg} | silent $delete _ | normal! gg<CR>";
              desc = "Template: note";
            }
            {
              key = "<C-j>";
              mode = ["n" "v" "x"];
              lua = true;
              action = ''
                function()
                  require('neoscroll').scroll(3, { move_cursor = true, duration = 30, easing = 'linear' })
                end
              '';
              desc = "Smooth scroll down";
            }
            {
              key = "<C-k>";
              mode = ["n" "v" "x"];
              lua = true;
              action = ''
                function()
                  require('neoscroll').scroll(-3, { move_cursor = true, duration = 30, easing = 'linear' })
                end
              '';
              desc = "Smooth scroll up";
            }
          ];
          terminal.toggleterm = {
            enable = true;
            setupOpts.direction = "float";
            lazygit.enable = true;
          };
          lsp = {
            enable = true;
            formatOnSave = true;
            lspkind.enable = true;
            lspsaga.enable = true;
            lightbulb.enable = true;
            trouble.enable = true;
            otter-nvim.enable = true;
          };
          opts = {
            expandtab = true;
            smartindent = true;
            tabstop = 2;
            shiftwidth = 2;
            softtabstop = 2;
          };
          languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;
            nix.enable = true;
            java.enable = true;
            markdown.enable = true;
            tex.enable = true;
            lua.enable = true;
            bash.enable = true;
            rust = {
              enable = true;
              extensions.crates-nvim.enable = true;
            };
          };
          autocomplete.blink-cmp.enable = true;
          ui = {
            borders.enable = true;
            noice.enable = true;
            colorizer.enable = true;
            illuminate.enable = true;
          };
          visuals = {
            nvim-scrollbar.enable = true;
            neoscroll-nvim = {
              enable = true;
              setupOpts.mappings = [];
            };
            nvim-web-devicons.enable = true;
            nvim-cursorline.enable = true;
            cinnamon-nvim.enable = true;
            fidget-nvim.enable = true;
            highlight-undo.enable = true;
          };
          theme = {
            enable = true;
            name = "kanagawa";
            style = "wave";
          };
          git = {
            enable = true;
            gitsigns.enable = true;
          };
          notes.neorg = {
            enable = true;
            treesitter.enable = true;
            setupOpts.load = {
              "core.defaults" = {};
              "core.concealer" = {};
              "core.integrations.telescope" = {};
              "core.dirman".config = {
                workspaces.notes = config.cfg.programs.nvf.notesDir;
                default_workspace = "notes";
                index = "index.norg";
              };
            };
          };
          luaConfigRC.neorg-filetype = ''
            vim.api.nvim_create_autocmd("FileType", {
              pattern = "norg",
              callback = function()
                vim.opt_local.wrap = true
                vim.opt_local.linebreak = true
                vim.opt_local.spell = true
              end,
            })
          '';

          binds = {
            whichKey.enable = true;
            cheatsheet.enable = true;
          };
          notify.nvim-notify.enable = true;
          presence.neocord.enable = true;
          autopairs.nvim-autopairs.enable = true;
          statusline.lualine.enable = true;
          tabline.nvimBufferline.enable = true;
          dashboard.alpha.enable = true;
          filetree.neo-tree.enable = true;
          telescope.enable = true;
          utility.motion.precognition.enable = true;
        };
      };
    };
  };
}
