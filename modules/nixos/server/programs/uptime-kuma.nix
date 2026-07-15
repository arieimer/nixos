{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.uptime-kuma;
in {
  options.cfg.programs.uptime-kuma.enable = mkEnableOption "uptime-kuma";
  config = mkIf cfg.enable {
    services.uptime-kuma = {
      enable = true;
      settings = {
      };
    };
  };
}
