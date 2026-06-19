{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.nginx.enable = mkEnableOption "nginx";
  config = mkIf config.cfg.system.nginx.enable {
    services.nginx = {
      enable = true;
    };
  };
}
