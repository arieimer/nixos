{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.paperless;
in {
  options.cfg.programs.paperless.enable = mkEnableOption "paperless";
  config = mkIf cfg.enable {
    sops.secrets."paperless_password" = {};
    services.paperless = {
      enable = true;
      database.createLocally = true;
      domain = "paperless.arieimer.net";
      passwordFile = config.sops.secrets."paperless_password".path;
      settings = {
        PAPERLESS_ADMIN_USER = "ari";
      };
    };
  };
}
