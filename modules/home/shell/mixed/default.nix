{
  config,
  lib,
  ...
}:
{
  options.cfg.shell.mixed.enable = lib.mkOption {
    # This shouldnt be modified...
    type = lib.types.bool;
    default = (config.cfg.shell.type == "mixed");
  };
  imports = [
    ./waybar
    ./fuzzel
    ./mako
    ./wleave
  ];
}
