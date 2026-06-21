{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.cfg.locale;
in {
  options.cfg.locale = mkOption {
    type = types.str;
    default = "en_US.UTF-8";
  };
  config = {
    i18n = {
      defaultLocale = cfg;
      extraLocaleSettings.LC_ALL = cfg;
    };
  };
}
