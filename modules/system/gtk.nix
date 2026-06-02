{
  config,
  pkgs,
  lib,
  ...
}:
let
 inherit (lib) mkEnableOption mkIf;
in
{
  options.cfg.system.gtk.enable = mkEnableOption "gtk";
  config = mkIf config.cfg.system.gtk.enable {
    hj = {
      packages = [
        pkgs.papirus-icon-theme
      ];
      xdg.config.files = {
        "gtk-3.0/settings.ini" = {
          generator = lib.generators.toINI {};
          value.Settings = {
            gtk-application-prefer-dark-theme = true; 
            gtk-icon-theme-name = "Papirus-Dark";
          };
        };
        "gtk-4.0/settings.ini" = {
          generator = lib.generators.toINI {};
          value.Settings = {
            gtk-application-prefer-dark-theme = true; 
            gtk-icon-theme-name = "Papirus-Dark";
          };
        };
      };
    };
    programs.dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            icon-theme = "Papirus-Dark";
            gtk-enable-primary-paste = false;
          };
          "org/gnome/desktop/wm/preferences" = {
            button-layout = ":";
          };
        };
      }
    ];
  };
}
