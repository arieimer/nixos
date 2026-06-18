{
  hostName,
  config,
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  hostsDir = ../../../../hosts;
  avatar = builtins.path {
    path = hostsDir + "/${hostName}/profile.png";
  };
in {
  options.cfg.programs.noctalia.enable = mkEnableOption "noctalia";
  config = mkIf config.cfg.programs.noctalia.enable {
    cfg.preservation.homeDirectories = [".local/state/noctalia"];
    hjem.extraModules = [
      inputs.noctalia.hjemModules.default
    ];
    hj = {
      programs.noctalia = {
        enable = true;
        settings = {
          shell = {
            time_format = "{:%-I:%M %p}";
            setup_wizard_enabled = false;
            telemetry_enabled = false;
            avatar_path = "${avatar}";
            polkit_agent = true;
            panel = {
              session_placement = "centered";
              wallpaper_placement = "centered";
            };
            launch_apps_as_systemd_services = true;
            screenshot = {
              directory = "~/Pictures/Screenshots";
              copy_to_clipboard = true;
            };
          };
          desktop_widgets.enabled = false;
          idle = {
            pre_action_fade_seconds = 5.0;
            behavior = {
              lock = {
                enabled = true;
                timeout = 600;
                command = "noctalia:session lock";
              };
              screen-off = {
                enabled = true;
                timeout = 1200;
                command = "noctalia:dpms-off";
                resume_command = "noctalia:dpms-on";
              };
            };
          };
          widget = {
            workspaces = {
              display = "none";
            };
            clock-12h = {
              type = "clock";
              format = "{:%-I:%M %p}";
              vertical_format = "{:%I\n%M\n—\n%m\n%d}";
            };
          };
          bar = {
            order = ["vertical"];
            vertical = {
              position = "left";
              enabled = true;
              auto_hide = false;
              reserve_space = true;
              radius = 0;
              margin_edge = 0;
              margin_ends = 0;
              capsule_group = [
                {
                  fill = "surface_variant";
                  id = "g1";
                  members = ["volume" "input_volume"];
                  opacity = 0.5;
                  padding = 6.0;
                }
                {
                  fill = "surface_variant";
                  id = "g2";
                  members = ["clock-12h"];
                  opacity = 0.5;
                  padding = 6.0;
                }
              ];
              start = [
                "workspaces"
              ];
              center = [
                # "clock-12h"
                "group:g2"
              ];
              end = [
                "tray"
                "group:g1"
              ];
            };
          };
          weather = {
            enabled = true;
            unit = "imperial";
          };
          control_center.shortcuts = [
            {
              type = "caffeine";
            }
            {
              type = "notification";
            }
            {
              type = "wallpaper";
            }
            {
              type = "mic_mute";
            }
          ];
          location.auto_locate = true;
          backdrop = {
            enabled = true;
            blur_intensity = 0.30;
            tint_intensity = 0.0;
          };
          wallpaper = {
            enabled = true;
            directory = "${inputs.wallpapers}/wallpapers";
          };
          theme = {
            source = "wallpaper";
            templates = {
              enable_builtin_templates = true;
              enable_community_templates = true;
              builtin_ids = [
                "ghostty"
                "niri"
                "btop"
              ];
              community_ids = [
                "discord"
              ];
            };
          };
        };
      };
    };
  };
}
