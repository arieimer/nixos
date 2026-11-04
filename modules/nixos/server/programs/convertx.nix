{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.convertX;
in {
  options.cfg.programs.convertX.enable = mkEnableOption "convertX";
  config = mkIf cfg.enable {
    cfg.system.caddy.proxies.convertX.port = 8098;
    cfg.programs.gatus.endpoint.convertX.url = "https://convertx.arieimer.net";
    virtualisation.oci-containers.containers.convertx = {
      image = "ghcr.io/c4illin/convertx:latest";
      ports = ["127.0.0.1:8098:3000"];
      volumes = ["/var/lib/convertx:/app/data"];
      environment = {
        ALLOW_UNAUTHENTICATED = "true";
        HTTP_ALLOWED = "true";
        ACCOUNT_REGISTRATION = "false";
        TZ = "America/Chicago";
      };
    };
    systemd.tmpfiles.rules = ["d /var/lib/convertx 0750 root root -"];
  };
}
