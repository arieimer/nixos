{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.cfg.system.xdg = {
    enable = mkEnableOption "xdg";
    userDirs.enable = mkOption {
      type = types.bool;
      default = config.cfg.system.xdg.enable;
    };
  };
  config = mkIf config.cfg.system.xdg.enable {
    cfg.preservation.directories = [
      "Documents"
      "Pictures"
      "Downloads"
    ];
    environment.sessionVariables = {
      XDG_DOCUMENTS_DIR = "$HOME/Documents";
      XDG_DOWNLOAD_DIR = "$HOME/Downloads";
      XDG_PICTURES_DIR = "$HOME/Pictures";
    };
  };
}
