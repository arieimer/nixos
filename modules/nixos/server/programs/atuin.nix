{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.atuin;
in {
  options.cfg.programs.atuin.enable = mkEnableOption "atuin";
  config = mkIf cfg.enable {
    cfg.system.caddy.proxies.atuin.port = 8888;
    cfg.programs.gatus.endpoint.Atuin = {
      url = "https://atuin.arieimer.net";
      conditions = [
        "[STATUS] == 200"
        "[RESPONSE_TIME] < 300"
        "[BODY].version != \"\""
      ];
    };
    services.atuin.enable = true;
  };
}
