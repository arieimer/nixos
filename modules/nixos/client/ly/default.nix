{
  lib,
  config,
  ...
}:
{
  options.cfg.ly.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables ly display manager";
  };
  config = lib.mkIf config.cfg.ly.enable {
    services.displayManager.ly.enable = true;
  };
}
