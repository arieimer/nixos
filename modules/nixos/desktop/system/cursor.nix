{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf gvariant;
  cfg = config.cfg.system.cursor;
  cursor-theme = "Bibata-Modern-Ice";
  cursor-size = 24;
  cursor-size-gv = gvariant.mkInt32 cursor-size;
in {
  options.cfg.system.cursor.enable = mkEnableOption "cursor";
  config = mkIf cfg.enable {
    hj.packages = [pkgs.bibata-cursors];
    environment.sessionVariables = {
      XCURSOR_THEME = cursor-theme;
      XCURSOR_SIZE = cursor-size;
    };
    programs.dconf.profiles.user.databases = [
      {
        settings."org/gnome/desktop/interface" = {
          inherit cursor-theme;
          cursor-size = cursor-size-gv;
        };
      }
    ];
  };
}
