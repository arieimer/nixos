{
  lib,
  config,
  ...
}:
{
  options.cfg.hypr.hyprland.monitors.list = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ "DP-1" ]; # This may cause hyprland to error when there is no DP-1 (possibly)
    description = "List of monitors that hyprland will use (First monitor is set to default)";
  };
  options.cfg.hypr.hyprland.monitors.settings = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [
      "desc:Lenovo, 1920x1080@240, 0x0, 1"
      "desc:LG, 1920x1080@75, 1920x0, 1"
    ];
    description = "format should be following: 'desc:Lenovo, 1920x1080@240, 0x0, 1'";
  };
  config = lib.mkIf config.cfg.hypr.hyprland.enable {
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          ", preferred, auto, 1"
        ] ++ config.cfg.hypr.hyprland.monitors.settings;
        cursor.default_monitor = builtins.elemAt config.cfg.hypr.hyprland.monitors.list 0;
      };
    };
  };
}
