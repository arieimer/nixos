{
  lib,
  config,
  ...
}:
{
  options.cfg.locale.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Sets up timezone, locale, keyboard layout";
  };
  options.cfg.locale.timeZone = lib.mkOption {
    type = lib.types.str;
    default = "America/Chicago";
  };
  options.cfg.locale.locale = lib.mkOption {
    type = lib.types.str;
    default = "en_US.UTF-8";
  };
  options.cfg.locale.keyLayout = lib.mkOption {
    type = lib.types.str;
    default = "us";
  };

  config = lib.mkIf config.cfg.locale.enable {
    time.timeZone = config.cfg.locale.timeZone;
    i18n.defaultLocale = config.cfg.locale.locale;
    console = {
      keyMap = config.cfg.locale.keyLayout;
    };
  };
}
