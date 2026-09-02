{
  hostName,
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.noctalia;
  hostsDir = ../../../../hosts;
  avatar = builtins.path {
    path = hostsDir + "/${hostName}/profile.png";
  };
in {
  options.cfg.programs.noctalia.enable = mkEnableOption "noctalia";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".local/state/noctalia"];
    sops.secrets."radicale_noctalia" = {
      owner = config.cfg.user.username;
      path = "/home/${config.cfg.user.username}/.local/state/noctalia/state.toml";
    };
    hjem.extraModules = [
      inputs.noctalia.hjemModules.default
    ];
    hj = {
      packages = [pkgs.songrec];
      programs.noctalia = {
        enable = true;
        package = pkgs.noctalia;
        settings = {
          shell = {
            time_format = "{:%-I:%M %p}";
            setup_wizard_enabled = false;
            telemetry_enabled = false;
            avatar_path = "${avatar}";
            polkit_agent = true;
            panel = {
              session_placement = "floating";
              session_position = "center";
              wallpaper_placement = "floating";
              wallpaper_position = "center";
            };
            launch_apps_as_systemd_services = true;
            screenshot = {
              directory = "~/Pictures/Screenshots";
              copy_to_clipboard = true;
            };
          };
          calendar = {
            enabled = true;
            refresh_minutes = 10;
            account.radicale = {
              type = "caldav";
              name = "School";
              provider = "custom";
              server_url = "https://radicale.arieimer.net";
              username = "ari";
            };
          };
          lockscreen_widgets = {
            enabled = true;
            schema_version = 2;
            widget_order = "lockscreen-login-box@DP-1";
            grid = {
              cell_size = 16;
              major_interval = 4;
              visible = true;
            };
            widget = {
              "lockscreen-login-box@DP-1" = {
                box_height = 229.0;
                box_width = 810.0;
                cx = 960.0;
                cy = 881.5;
                output = "DP-1";
                rotation = 0.0;
                type = "login_box";
                settings = {
                  background_color = "surface_variant";
                  background_opacity = 0.88;
                  background_radius = 12.0;
                  center_password_text = false;
                  input_opacity = 1.0;
                  input_radius = 6.0;
                  layout = "regular";
                  show_caps_lock = true;
                  show_keyboard_layout = true;
                  show_login_button = true;
                  show_media = false;
                  show_session_buttons = true;
                  show_weather = true;
                };
              };
            };
          };
          desktop_widgets.enabled = false;
          idle = {
            behavior_order = ["lock" "screen-off"];
            pre_action_fade_seconds = 5.0;
            behavior = {
              lock = {
                enabled = true;
                timeout = 600.0;
                command = "noctalia:session lock";
              };
              screen-off = {
                enabled = true;
                timeout = 1200.0;
                command = "noctalia:dpms-off";
                resume_command = "noctalia:dpms-on";
              };
            };
          };
          widget = {
            workspaces = {
              show_labels = false;
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
                "gtk3"
                "gtk4"
                "qt"
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
