{
  config,
  lib,
  ...
}:
{
  options.cfg.shell.type = lib.mkOption {
    type = lib.types.str;
    default = "mixed";
    description = "Chooses the shell type";
  };
  options.cfg.shell.launcher = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "launcher executable";
  };
  options.cfg.shell.power = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "Powermenu executable";
  };
  imports = [
    ./mixed
  ];
}
