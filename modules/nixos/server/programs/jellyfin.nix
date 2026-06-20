{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.jellyfin.enable = mkEnableOption "jellyfin";
  config = mkIf config.cfg.system.jellyfin.enable {
    cfg.preservation.directories = ["/var/lib/jellyfin"];
    systemd.tmpfiles.rules = [
      "d /var/lib/jellyfin 0700 jellyfin jellyfin -"
    ];
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
