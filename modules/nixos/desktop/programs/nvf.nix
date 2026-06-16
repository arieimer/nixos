{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  imports = [inputs.nvf.nixosModules.default];
  options.cfg.programs.nvf.enable = mkEnableOption "nvf";
  config = mkIf config.cfg.programs.nvf.enable {
    environment.sessionVariables = {
      EDITOR = "nvim";
    };
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          autocmds = [
            {
              # remove when nvf#1937 is fixed
              enable = true;
              event = ["BufEnter"];
              pattern = ["*"];
              command = "setlocal indentexpr=nvim_treesitter#indent()";
            }
          ];
          viAlias = true;
          vimAlias = true;
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
          };
          languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;

            nix.enable = true;
            markdown.enable = true;
            bash.enable = true;
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
          git = {
            enable = true;
            gitsigns.enable = true;
          };
          binds = {
            whichKey.enable = true;
            cheatsheet.enable = true;
          };
          theme.enable = true;
          notify.nvim-notify.enable = true;
          presence.neocord.enable = true;
          autopairs.nvim-autopairs.enable = true;
          statusline.lualine.enable = true;
          filetree.neo-tree.enable = true;
        };
      };
    };
  };
}
