{
  lib,
  config,
  ...
}:
{
  options.cfg.hypr.hyprpaper.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures hyprpaper";
  };
  #options.cfg.hypr.hyprpaper.image = lib.mkOption {
  #  type = lib.types.str;
  #  default = "forest-everforest";
  #  description = "Selects which image to be used to set the background up";
  #};
  config = lib.mkIf config.cfg.hypr.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        splash = true;
        #preload = [ "${config.cfg.hypr.hyprpaper.image}" ];
        #wallpaper = [ ",${config.cfg.hypr.hyprpaper.image}" ];
      };
    };
  };
}
