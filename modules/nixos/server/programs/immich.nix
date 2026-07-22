{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.immich;
in {
  options.cfg.programs.immich.enable = mkEnableOption "immich";
  config = mkIf cfg.enable {
    cfg.system.caddy.proxies.immich.port = 2283;
    cfg.programs.gatus.endpoint.Immich.url = "https://immich.arieimer.net";
    services.immich = {
      enable = true;
      mediaLocation = "/srv/tampa/immich";
    };
    systemd.tmpfiles.rules = [
      "d /srv/tampa/immich 02775 ${config.services.immich.user} ${config.services.immich.group} -"
    ];
    systemd.services.immich-server.unitConfig.RequiresMountsFor = ["/srv/tampa"];
  };
}
