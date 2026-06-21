{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.qbittorrent;
in {
  options.cfg.programs.qbittorrent.enable = mkEnableOption "qbittorrent";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".config/qBittorrent"];
    hj = {
      packages = [
        pkgs.qbittorrent-enhanced
      ];
    };
  };
}
