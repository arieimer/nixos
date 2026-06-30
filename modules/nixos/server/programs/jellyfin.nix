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
    cfg.preservation.homeDirectories = ["Media/Music"];
    cfg.preservation.directories = [
      {
        directory = "/var/lib/jellyfin";
        user = "jellyfin";
        group = "jellyfin";
        mode = "0700";
      }
      {
        directory = "/var/cache/jellyfin";
        user = "jellyfin";
        group = "jellyfin";
        mode = "0700";
      }
    ];
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
