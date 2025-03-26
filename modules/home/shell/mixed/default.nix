{
  config,
  lib,
  ...
}:
{
  options.cfg.shell.mixed.enable = lib.mkOption {
    type = lib.types.bool;
    default = (config.cfg.shell.type == "mixed"); # Not be used normally
  };
  imports = [
    ./waybar
    ./fuzzel
    ./mako
  ];
}
