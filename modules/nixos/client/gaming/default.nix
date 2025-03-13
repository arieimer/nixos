{
  lib,
  ...
}:
{
  options.cfg.gaming.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables gaming tools";
  };
  imports = [
    ./gamemode
    ./steam
  ];
}
