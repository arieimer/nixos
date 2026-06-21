{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf generators;
  cfg = config.cfg.programs.ghostty;
in {
  options.cfg.programs.ghostty.enable = mkEnableOption "ghostty";
  config = mkIf cfg.enable {
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
      files.".ssh/config".text = ''
        Host *
        SetEnv TERM=xterm-256color
      '';
    };
  };
}
