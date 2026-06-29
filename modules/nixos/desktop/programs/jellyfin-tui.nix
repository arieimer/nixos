{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.jellyfin-tui;
in {
  options.cfg.programs.jellyfin-tui.enable = mkEnableOption "jellyfin-tui";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".local/share/jellyfin-tui"];
    hj = {
      packages = [
        pkgs.jellyfin-tui
      ];
      xdg.config.files."jellyfin-tui/config.yaml" = {
        generator = lib.generators.toYAML {};
        value = {
          servers = [
            {
              name = "katei";
              quick_connect = true;
              url = "https://katei:8096";
            }
          ];
        };
      };
    };
  };
}
