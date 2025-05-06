{
  osConfig,
  config,
  lib,
  ...
}:
{
  options.cfg.hypr.hypridle.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures hypridle.";
  };
  options.cfg.hypr.hypridle.dpmsTimeout = lib.mkOption {
    type = lib.types.int;
    default = 300;
    description = ''
      Sets the time in seconds for your screen to turn off when idle.
      If you set this to 0, the screen won't turn off when idle.'';
  };
  options.cfg.hypr.hypridle.lockTimeout = lib.mkOption {
    type = lib.types.int;
    default = 330;
    description = ''
      Sets the time in seconds for the PC to automatically lock when idle.
      If you set this to 0, the PC won't lock when idle.'';
  };
  options.cfg.hypr.hypridle.suspendTimeout = lib.mkOption {
    type = lib.types.int;
    default = 1800;
    description = ''
      Sets the time in seconds for the PC to automatically lock when idle.
      If you set this to 0, the PC won't lock when idle.'';
  };
  config = lib.mkIf config.cfg.hypr.hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof ${lib.getExe config.programs.hyprlock.package} || ${lib.getExe config.programs.hyprlock.package}";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "${lib.getExe' osConfig.programs.hyprland.package "hyprctl"} dispatch dpms on";
          ignore_dbus_inhibit = false;
          ignore_systemd_inhibit = false;
        };
        listener =
          lib.optionals (config.cfg.hypr.hypridle.dpmsTimeout != 0) [
            {
              timeout = config.cfg.hypr.hypridle.dpmsTimeout;
              on-timeout = "${lib.getExe' osConfig.programs.hyprland.package "hyprctl"} dispatch dpms off";
              on-resume = "${lib.getExe' osConfig.programs.hyprland.package "hyprctl"} dispatch dpms on";
            }
          ]
          ++ lib.optionals (config.cfg.hypr.hypridle.lockTimeout != 0) [
            {
              timeout = config.cfg.hypr.hypridle.lockTimeout;
              on-timeout = "loginctl lock-session";
            }
          ]
          ++ lib.optionals (config.cfg.hypr.hypridle.suspendTimeout != 0) [
            {
              timeout = config.cfg.hypr.hypridle.suspendTimeout;
              on-timeout = "systemctl suspend";
            }
          ];
      };
    };
  };
}
