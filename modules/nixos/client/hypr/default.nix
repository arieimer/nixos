{
  options,
  config,
  lib,
  ...
}:
{
  options.cfg.hypr.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables Hyprland with UWSM";
  };
  config = lib.mkIf config.cfg.hypr.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
    programs.uwsm.enable = true;
    environment.variables = {
      XDG_PICTURES_DIR = "$HOME/Pictures";
    };
  };
}
