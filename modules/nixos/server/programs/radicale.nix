{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.radicale;
in {
  options.cfg.programs.radicale.enable = mkEnableOption "radicale";
  config = mkIf cfg.enable {
    cfg.system.caddy.proxies.radicale.port = 5232;
    sops.secrets.radicale.owner = config.services.radicale.user;
    services.radicale = {
      enable = true;
      settings = {
        auth = {
          type = "htpasswd";
          htpasswd_filename = config.sops.secrets.radicale.path;
          htpasswd_encryption = "bcrypt";
        };
      };
    };
  };
}
