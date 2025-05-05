{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.cfg.hypr.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      general = {
        border_size = 2;
        gaps_out = 4;
        gaps_in = 2;
      };
      decoration = {
        rounding = 4;
        active_opacity = 0.97;
        inactive_opacity = 0.92;
      };
      windowrule = [
        "opaque, class:^(.*Minecraft.*)$"
        "opaque, class:^(.*zen.*)$"
        "opaque, class:^(.*mpv.*)$"
      ];
      misc = {
        disable_splash_rendering = 1;
      };
    };
  };
}
