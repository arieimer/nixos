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
    cfg.preservation.directories = [
      {
        directory = "/var/lib/jellyfin";
        user = config.services.jellyfin.user;
        group = config.services.jellyfin.group;
        mode = "2775";
      }
      {
        directory = "/var/cache/jellyfin";
        user = config.services.jellyfin.user;
        group = config.services.jellyfin.group;
        mode = "2750";
      }
    ];
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = "jellyfin";
      group = "jellyfin";
    };
    systemd.tmpfiles.rules = [
      "d /var/lib/jellyfin/Media 2775 ${config.services.jellyfin.user} ${config.services.jellyfin.group} -"
      "d /var/lib/jellyfin/Media/Music 2775 ${config.services.jellyfin.user} ${config.services.jellyfin.group} -"
      "L+ /home/${config.cfg.user.username}/Media - ${config.services.jellyfin.user} ${config.services.jellyfin.group} - /var/lib/jellyfin/Media"
    ];
    cfg.user.extraGroups = ["jellyfin"];
  };
}
