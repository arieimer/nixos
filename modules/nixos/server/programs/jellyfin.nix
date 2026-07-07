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
      extraOptions = ["--network=host" "--device=/dev/dri:/dev/dri"];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "America/Chicago";
      };
      volumes = [
        "jellyfin-config:/config"
        "/home/${config.cfg.user.username}/Media:/media"
      ];
      autoStart = true;
    };
    hj.files = {
      "Media/Music".type = "directory";
    };
  };
}
