{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.lazygit.enable = mkEnableOption "lazygit";
  config = mkIf config.cfg.programs.lazygit.enable {
    hj = {
      packages = [
        pkgs.lazygit
      ];
      xdg.config.files."lazygit/config.yml" = {
        generator = lib.generators.toYAML {};
        value = {
          gui.showIcons = true;
          disableStartupPopups = true;
        };
      };
    };
  };
}
