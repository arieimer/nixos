{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.jellyfin.enable = mkEnableOption "jellyfin";
  config = mkIf config.cfg.system.jellyfin.enable {
    services.jellyfin = {
      enable = true;
    };
  };
}
