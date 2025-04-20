{
  config,
  lib,
  ...
}:
{
  options.cfg.hypr.hypridle.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables hypridle daemon";
  };
  options.cfg.hypr.hypridle.timeout = lib.mkOption {
    type = lib.types.int;
    default = 300;
    description = "Timeout time";
  };

  config = lib.mkIf config.cfg.hypr.hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = config.cfg.hypr.hypridle.timeout;
            # on-timeout = "hyprctl dispatch dpms off";
            # on-resume = "hyprctl dispatch dmps on"; 
          }
          {
            timeout = (config.cfg.hypr.hypridle.timeout + 30);
            on-timeout = "loginctl lock-session";
          }
        ];
      };
    };
  };
}
