{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  locale = config.cfg.locale;
in {
  options.cfg.locale = mkOption {
    type = types.str;
    default = "en_US.UTF-8";
  };
  config = {
    i18n = {
      defaultLocale = locale;
      extraLocaleSettings.LC_ALL = locale;
    };
  };
}
