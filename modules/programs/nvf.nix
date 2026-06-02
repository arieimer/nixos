{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [
    inputs.nvf.nixosModules.default
  ];
  options.cfg.programs.nvf.enable = mkEnableOption "nvf";
  config = mkIf config.cfg.programs.nvf.enable {
    environment.sessionVariables = {
      EDITOR = "nvim";
    };
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          lsp = {
            enable = true;
          };
          opts = {
            expandtab = true;
          };
          languages = {
            enableFormat = true;
            enableTreesitter = true;

            nix.enable = true;
            lua.enable = true;
            markdown.enable = true;
          };
          autocomplete.blink-cmp.enable = true;
          visuals = {
            nvim-scrollbar.enable = true;
            nvim-cursorline.enable = true;
            cinnamon-nvim.enable = true;
            fidget-nvim.enable = true;
            highlight-undo.enable = true;
            blink-indent.enable = true;
          };
          autopairs.nvim-autopairs.enable = true;
          statusline.lualine.enable = true;
          filetree.neo-tree.enable = true;
        };
      };
    };
  };
}
