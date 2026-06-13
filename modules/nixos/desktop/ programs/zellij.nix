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
        keybinds clear-defaults=true {
          locked {
            bind "Ctrl b" { SwitchToMode "Normal"; }
          }
          tab {
            bind "Ctrl t" { SwitchToMode "Normal"; }
          }
          pane {
            bind "Ctrl p" { SwitchToMode "Normal"; }
          }
          shared_except "normal" "locked" {
            bind "Esc" { SwitchToMode "Normal"; }
          }
          shared_except "pane" "locked" {
            bind "Ctrl p" { SwitchToMode "Pane"; }
          }
          shared_except "tab" "locked" {
            bind "Ctrl t" { SwitchToMode "Tab"; }
          }
          shared_except "locked" {
            bind "Ctrl b" { SwitchToMode "Locked"; }
            bind "Ctrl q" { Quit; }
          }
        }
        plugins {
          compact-bar location="zellij:compact-bar" {
            tooltip "F1"
          }
        }
      '';
    };
  };
}
