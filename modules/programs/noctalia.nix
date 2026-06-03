{
  hostName,
  config,
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.noctalia.enable = mkEnableOption "noctalia";
  config = mkIf config.cfg.programs.noctalia.enable {
    cfg.preservation.directories = [".local/state/noctalia"];
    hjem.extraModules = [
      inputs.noctalia.hjemModules.default
    ];
    hj = {
      programs.noctalia = {
        enable = true;
        settings = {
          shell = {
            setup_wizard_enabled = false;
            telemetry_enabled = false;
            avatar_path = "${config.programs.nh.flake}/hosts/${hostName}/profile.png";
            polkit_agent = true;
            launch_apps_as_systemd_services = true;
            screenshot = {
              directory = "~/Pictures/Screenshots";
              copy_to_clipboard = true;
            };
          };
          widget = {
            workspaces = {
              display = "none";
            };
            clock-12h = {
              type = "clock";
              format = "{:%-I:%M %p}";
            };
          };
          bar = {
            order = ["main"];
            main = {
              position = "top";
              enabled = true;
              auto_hide = false;
              reserve_space = true;
              radius_top_left = 0;
              radius_top_right = 0;
              margin_edge = 0;
              margin_ends = 40;
              start = [
                "launcher"
                "workspaces"
              ];
              center = [
                "clock-12h"
              ];
              end = [
                "tray"
                "volume"
                "session"
              ];
            };
          };
          weather = {
            enabled = true;
            unit = "imperial";
          };
          location.auto_locate = true;
          backdrop = {
            enabled = true;
            blur_intensity = 0.10;
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
