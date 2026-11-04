{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.nvf;
in {
  options.cfg.programs.nvf.enable = mkEnableOption "nvf";

  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      defaultEditor = true;
      settings.vim = {
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
        ];
        terminal.toggleterm = {
          enable = true;
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
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
        };
        spellcheck.enable = true;
        theme = {
          enable = true;
          name = "kanagawa";
          style = "wave";
        };
        git = {
          enable = true;
          gitsigns.enable = true;
        };
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
}
