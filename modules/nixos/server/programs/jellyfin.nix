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
    virtualisation.oci-containers.containers.jellyfin = {
      image = "lscr.io/linuxserver/jellyfin:latest";
      extraOptions = [
        "--network=host"
        "--device=/dev/dri:/dev/dri"
        "--health-cmd=\"curl -f http://localhost:8096/health || exit 1\""
        "--health-interval=30s"
        "--health-timeout=10s"
        "--health-retries=3"
        "--health-start-period=60s"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "America/Chicago";
      };
      volumes = [
        "/home/${config.cfg.user.username}/Jellyfin:/config"
        "/home/${config.cfg.user.username}/Media:/media"
      ];
      autoStart = true;
    };
    cfg.preservation.homeDirectories = [
      "Media/Music"
      "Jellyfin"
    ];
  };
}
