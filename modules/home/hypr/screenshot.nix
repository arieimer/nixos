{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.cfg.hypr.screenshot.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables a script to take screenshots and sets binds";
  };
  imports = [
    ../../../packages/scripts/screenshot/default.nix
  ];
  config = lib.mkIf config.cfg.hypr.screenshot.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "CTRL, ESCAPE, exec, screenshot.sh --selection"
        "CTRL SHIFT, ESCAPE, exec, screenshot.sh --monitor"
      ];
      layerrule = [
        "noanim,selection" # screenshot border fix
      ];
    };
  };
}
