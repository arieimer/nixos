{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf generators;
in {
  options.cfg.programs.ghostty.enable = mkEnableOption "ghostty";
  config = mkIf config.cfg.programs.ghostty.enable {
    hj = {
      packages = [
        pkgs.ghostty
      ];
      xdg.config.files."ghostty/config.ghostty" = {
        generator = generators.toKeyValue {};
        value = {
          theme = "noctalia";
          confirm-close-surface = false;
          working-directory = "home";
        };
      };
    };
  };
}
