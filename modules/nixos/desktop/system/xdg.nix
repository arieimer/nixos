{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.xdg;
in {
  options.cfg.system.xdg.enable = mkEnableOption "xdg";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [
      "Documents"
      "Pictures"
      "Downloads"
      "Videos"
    ];
    environment.sessionVariables = {
      XDG_DOCUMENTS_DIR = "$HOME/Documents";
      XDG_DOWNLOAD_DIR = "$HOME/Downloads";
      XDG_PICTURES_DIR = "$HOME/Pictures";
      XDG_VIDEOS_DIR = "$HOME/Videos";
    };
  };
}
