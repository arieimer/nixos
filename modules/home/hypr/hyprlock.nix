{
  lib,
  config,
  ...
}:
let
  display = builtins.elemAt config.cfg.hypr.hyprland.monitors.list 0;
in
{
  options.cfg.hypr.hyprlock.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables hyprlock";
  };
  config = lib.mkIf config.cfg.hypr.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          disable_loading_bar = true;
          immediate_render = true;
          ignore_empty_input = true;
        };
        background = {
          contrast = 1;
          brightness = 0.8;
          vibrancy = 1;
          blur_size = 3;
          blur_passes = 3;
        };
        input-field = {
          monitor = display;
          size = "350, 45";
          outline_thickness = 2;
          rounding = 0;
          dots_size = 0.25;
          dots_spacing = 0.66;
          dots_center = true;
          placeholder_text = ''<span font="monospace"><i>Password...</i></span>'';
          fail_text = ''<span font="monospace"><i>Incorrect.</i></span>'';
          hide_input = false;
          position = "0, 140";
          halign = "center";
          valign = "bottom";
        };
        label = [
          {
            monitor = display;
            text = "cmd[update:1000] echo \"<span>$(date +\"%I:%M\")</span>\"";
            font_size = 125;
            position = "0, 70";
            halign = "center";
            valign = "center";
          }
          {
            monitor = display;
            text = "cmd[update:1000] echo \"<span>$(date +\"%A, %B %-d\")</span>\"";
            font_size = 40;
            position = "0, -50";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
