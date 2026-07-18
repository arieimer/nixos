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
    cfg.system.caddy.proxies.paperless.port = 28981;
    cfg.programs.gatus.endpoint.Paperless.url = "https://paperless.arieimer.net";
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
