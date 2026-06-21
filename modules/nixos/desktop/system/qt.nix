{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.qt;
in {
  options.cfg.system.qt.enable = mkEnableOption "qt";
  config = mkIf cfg.enable {
    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };
    hj = {
      packages = [
        pkgs.adwaita-qt6
        pkgs.qt6Packages.qt6ct
      ];
      xdg.config.files."qt6ct/qt6ct.conf" = {
        generator = lib.generators.toINI {};
        value.Appearance.style = "Adwaita-Dark";
      };
    };
  };
}
