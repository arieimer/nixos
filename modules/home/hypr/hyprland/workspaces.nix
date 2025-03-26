{
  config,
  lib,
  ...
}:
let
workspaces = builtins.concatLists ( lib.imap0 (i: v: builtins.genList (x: builtins.toString((x+1)+(i*10)) + ", monitor:" + v) 10 ) config.cfg.hypr.hyprland.monitors.list );
in
{
  config = lib.mkIf config.cfg.hypr.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      workspace = workspaces;
    };
  };
}
