{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.jellyfin;
in {
  options.cfg.programs.jellyfin.enable = mkEnableOption "jellyfin";
  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      hardwareAcceleration = {
        enable = true;
        type = "amf";
        device = "/dev/dri/renderD128";
      };
    };
  };
}
