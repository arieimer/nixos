{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.jellyfin;
  usr = config.cfg.user.username;
in {
  options.cfg.programs.jellyfin.enable = mkEnableOption "jellyfin";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".local/share/jellyfin" ".local/state/jellyfin" ".cache/jellyfin" "Media"];
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = usr;
      group = "users";
      dataDir = "/home/${usr}/.local/share/jellyfin";
      cacheDir = "/home/${usr}/.cache/jellyfin";
      logDir = "/home/${usr}/.local/state/jellyfin/log";
    };
  };
}
