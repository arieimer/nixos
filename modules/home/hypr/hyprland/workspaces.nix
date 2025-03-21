{
  lib,
  config,
}:
let
  generateWorkspace = index: monitor:
    builtins.genList
in
{
  config = lib.mkIf config.cfg.hypr.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      workspace = builtins.getList ()
    };
    
  };
}
