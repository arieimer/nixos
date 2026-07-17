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
    services.atuin.enable = true;
  };
}
