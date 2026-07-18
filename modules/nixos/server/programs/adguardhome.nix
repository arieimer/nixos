{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.adguardhome;
in {
  options.cfg.programs.adguardhome.enable = mkEnableOption "adguard-home";
  config = mkIf cfg.enable {
    cfg.system.caddy.proxies.adguard.port = 3000;
    cfg.programs.gatus.endpoint.AdGuardHome.url = "https://adguard.arieimer.net";
    services.adguardhome = {
      enable = true;
      mutableSettings = false;
      settings = {
        http = {
          address = "100.83.82.126:3000";
        };
        dns = {
          bind_hosts = [
            "100.83.82.126"
          ];
          bootstrap_dns = [
            "9.9.9.10"
            "149.112.112.112"
            "1.1.1.1"
            "2620:fe::fe"
          ];
          port = 53;
        };
        filtering.blocked_services = {
          ids = [
            "reddit"
            "twitter"
          ];
        };
      };
    };
  };
}
