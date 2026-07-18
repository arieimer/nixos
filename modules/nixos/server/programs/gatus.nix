{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types mapAttrsToList;
  cfg = config.cfg.programs.gatus;
in {
  options.cfg.programs.gatus = {
    enable = mkEnableOption "gatus";
    endpoint = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          url = mkOption {
            type = types.str;
          };
          interval = mkOption {
            type = types.str;
            default = "5m";
          };
          conditions = mkOption {
            type = types.listOf types.str;
            default = [
              "[STATUS] == 200"
              "[RESPONSE_TIME] < 300"
            ];
          };
        };
      });
    };
  };
  config = mkIf cfg.enable {
    cfg.system.caddy.proxies.status.port = 3001;
    services.gatus = {
      enable = true;
      settings = {
        web.port = 3001;
        endpoints = mapAttrsToList (name: value: value // {inherit name;}) cfg.endpoint;
      };
    };
  };
}
