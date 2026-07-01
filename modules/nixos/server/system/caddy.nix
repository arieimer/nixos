{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.caddy;
in {
  options.cfg.system.caddy.enable = mkEnableOption "caddy";
  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;
      virtualHosts."http://aomori" = {
        extraConfig = ''
          reverse_proxy localhost:8096
        '';
      };
    };
  };
}
