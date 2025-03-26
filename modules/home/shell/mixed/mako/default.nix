{
  config,
  lib,
  ...
}:
{
  options.cfg.shell.mixed.mako.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.shell.mixed.enable;
    description = "Installs and configures mako a notification daemon";
  };

  config = lib.mkIf config.cfg.shell.mixed.mako.enable {
    services.mako = {
      enable = true;
      icons = true;
    };
  };
}
