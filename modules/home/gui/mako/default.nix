{
  config,
  lib,
  ...
}:
{
  options.cfg.gui.mako.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures mako a notification daemon";
  };

  config = lib.mkIf config.cfg.gui.mako.enable {
    services.mako = {
      enable = true;
      icons = true;
    };
  };
}
