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
    environment.systemPackages = [pkgs.ghostty-bin];
    hj = {
      xdg.config.files."ghostty/config.ghostty" = {
        generator = generators.toKeyValue {};
        value = {
          background = "101014";
          background-opacity = 0.85;
          confirm-close-surface = false;
          working-directory = "home";
          macos-titlebar-proxy-icon = "hidden";
          macos-titlebar-style = "hidden";
          # window-decoration = "none";
          title = " ";
        };
      };
      files.".ssh/config".text = ''
        Host *
        SetEnv TERM=xterm-256color
      '';
    };
  };
}
