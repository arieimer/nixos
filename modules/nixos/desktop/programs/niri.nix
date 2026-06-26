{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types concatStringsSep optionalString mapAttrsToList;
  cfg = config.cfg.programs.niri;
  monitorSettings = name: monitor: ''
    output "${name}" {
      mode "${monitor.mode}"
      scale ${toString monitor.scale}
      position ${monitor.position}
      ${optionalString (monitor.transform != null) ''transform "${monitor.transform}"''}
      ${optionalString monitor.focusAtStartup "focus-at-startup"}
      ${monitor.extraConfig}
    }
  '';
  workspaceBinds = concatStringsSep "\n" (builtins.concatLists (
    builtins.genList (
      i: let
        n = i + 1;
        key =
          if n == 10
          then "0"
          else toString n;
      in [
        "Mod+${key} { focus-workspace ${toString n}; }"
        "Mod+Shift+${key} { move-window-to-workspace ${toString n}; }"
      ]
    )
    10
  ));
in {
  options.cfg.programs.niri = {
    enable = mkEnableOption "niri";
    monitors = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          mode = mkOption {
            type = types.str;
            example = "1920x1080@60";
          };
          scale = mkOption {
            type = types.either types.int types.float;
            default = 1;
          };
          position = mkOption {
            type = types.str;
            example = "0,0";
          };
          transform = mkOption {
            type = types.nullOr (types.enum [
              "normal"
              "90"
              "180"
              "270"
              "flipped"
              "flipped-90"
              "flipped-180"
              "flipped-270"
            ]);
            default = null;
          };
          focusAtStartup = mkOption {
            type = types.bool;
            default = false;
          };
          extraConfig = mkOption {
            type = types.lines;
            default = "";
          };
        };
      });
    };
  };
  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
    };
    xdg.portal.config.niri."org.freedesktop.impl.portal.FileChooser" = ["gtk"];
    hj = {
      packages = [
        pkgs.xwayland-satellite
      ];
      xdg.config.files."niri/config.kdl".text = ''
        ${concatStringsSep "\n" (mapAttrsToList monitorSettings cfg.monitors)}
        window-rule {
          geometry-corner-radius 15
          clip-to-geometry true
        }
        prefer-no-csd
        window-rule {
          match app-id="dev.noctalia.Noctalia.Settings"
          open-floating true
          default-column-width { fixed 1080; }
          default-window-height { fixed 920; }
        }
        window-rule {
          match is-active=true
          opacity 0.97
        }
        window-rule {
          match is-active=false
          opacity 0.94
        }
        window-rule {
          match app-id="steam" title=r#"^notificationtoasts_\d+_desktop$"#
          default-floating-position x=10 y=10 relative-to="bottom-right"
        }
        window-rule {
          match app-id="zen"
          opacity 1.0
        }
        window-rule {
          match app-id=r#"^io\.ente\.auth$"#
          block-out-from "screencast"
        }
        cursor {
          xcursor-theme "Bibata-Modern-Ice"
          xcursor-size 24
        }
        clipboard {
          disable-primary
        }
        input {
          focus-follows-mouse max-scroll-amount="0%"
          warp-mouse-to-focus
        }
        hotkey-overlay {
          skip-at-startup
        }
        layer-rule {
          match namespace="^noctalia-backdrop"
          place-within-backdrop true
        }
        gestures {
          hot-corners {
            off
          }
        }
        recent-windows {
          off
        }
        debug {
          honor-xdg-activation-with-invalid-serial
        }
        binds {
          Mod+Tab { spawn-sh "noctalia msg panel-toggle launcher"; }
          Mod+S { spawn-sh "noctalia msg panel-toggle control-center"; }
          Mod+Comma { spawn-sh "noctalia msg settings-toggle"; }
          Mod+P { spawn-sh "noctalia msg panel-toggle session"; }
          Mod+E {spawn-sh "noctalia msg screenshot-region"; }
          Mod+Shift+E {spawn-sh "noctalia msg screenshot-fullscreen"; }
          Mod+Shift+Ctrl+E {spawn-sh "noctalia msg screenshot-fullscreen all"; }

          Mod+Return { spawn "ghostty"; }
          Mod+Q { close-window; }

          Mod+A { toggle-window-floating; }
          Mod+Shift+A { switch-focus-between-floating-and-tiling; }
          Mod+H { focus-column-left; }
          Mod+L { focus-column-right; }
          Mod+J { focus-window-or-workspace-down; }
          Mod+K { focus-window-or-workspace-up; }
          Mod+Ctrl+L { focus-monitor-right; }
          Mod+Ctrl+H { focus-monitor-left;  }
          Mod+Ctrl+K { focus-monitor-up;    }
          Mod+Ctrl+J { focus-monitor-down;  }
          Mod+Shift+Ctrl+L { move-column-to-monitor-right; }
          Mod+Shift+Ctrl+H { move-column-to-monitor-left; }
          Mod+Shift+Ctrl+K { move-column-to-monitor-up; }
          Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
          Mod+Shift+H { move-column-left; }
          Mod+Shift+L { move-column-right; }
          Mod+Shift+J { move-window-to-workspace-down; }
          Mod+Shift+K { move-window-to-workspace-up; }
          Mod+R { switch-preset-column-width; }
          Mod+Shift+R { switch-preset-window-height; }
          Mod+F { maximize-column; }
          Mod+Shift+F { fullscreen-window; }
          Mod+C { center-column; }
          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }
          Mod+Space { toggle-overview; }

          XF86AudioRaiseVolume { spawn-sh "noctalia msg volume-up"; }
          XF86AudioLowerVolume { spawn-sh "noctalia msg volume-down"; }
          XF86AudioMute { spawn-sh "noctalia msg volume-mute"; }
          XF86MonBrightnessUp { spawn-sh "noctalia msg brightness-up"; }
          XF86MonBrightnessDown { spawn-sh "noctalia msg brightness-down"; }

          ${workspaceBinds}

        }
        spawn-at-startup "noctalia"
        spawn-sh-at-startup "fcitx5 -d"
        spawn-at-startup "udiskie"
        include optional=true "noctalia.kdl"
      '';
    };
  };
}
