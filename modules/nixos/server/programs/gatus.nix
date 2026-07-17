{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.gatus;
in {
  options.cfg.programs.gatus.enable = mkEnableOption "gatus";
  config = mkIf cfg.enable {
    cfg.system.caddy.proxies.status.port = 3001;
    services.gatus = {
      enable = true;
      settings = {
        web.port = 3001;
        endpoints = [
          {
            name = "AdGuardHome";
            url = "https://adguard.arieimer.net";
            interval = "5m";
            conditions = [
              "[STATUS] == 200"
              "[RESPONSE_TIME] < 300"
            ];
          }
          {
            name = "Atuin";
            url = "https://atuin.arieimer.net";
            interval = "5m";
            conditions = [
              "[STATUS] == 200"
              "[RESPONSE_TIME] < 300"
              "[BODY].version != \"\""
            ];
          }
        ];
      };
    };
  };
}
