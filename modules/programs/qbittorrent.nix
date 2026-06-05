{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.qbittorrent.enable = mkEnableOption "qbittorrent";
  config = mkIf config.cfg.programs.qbittorrent.enable {
    cfg.preservation.directories = [".config/qBittorrent"];
    hj = {
      packages = [
        pkgs.qbittorrent-enhanced
      ];
    };
  };
}
