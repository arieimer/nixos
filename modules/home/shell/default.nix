{
  config,
  lib,
  ...
}:
{
  options.cfg.shell.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables the selected shell";
  };
  options.cfg.shell.type = lib.mkOption {
    type = lib.types.str;
    default = "mixed";
    description = "Chooses the shell type";
  };
  imports = [
    ./mixed
  ];
}
