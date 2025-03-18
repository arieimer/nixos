{
  lib,
  config,
}:
let
  wrk = lib.lists.forEach config.cfg.hypr.hyprland.monitors.list (mon:
    builtins.getList (mon: )
  );
{
  config = lib.mkIf config.cfg.hypr.hyprland.enable {
    #wayland.windowManager.hyprland.settings.workspace =
  };
}
