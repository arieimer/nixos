{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.zellij.enable = mkEnableOption "zellij";
  config = mkIf config.cfg.programs.zellij.enable {
    hj = {
      packages = [
        pkgs.zellij
      ];
      xdg.config.files."zellij/config.kdl".text = ''
        show_startup_tips false
        plugins {
          compact-bar location="zellij:compact-bar" {
            tooltip "F1"
          }
        }
      '';
    };
  };
}
