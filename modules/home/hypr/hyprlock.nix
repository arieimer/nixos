{
  lib,
  config,
  ...
}:
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
      };
    };
  };
}
