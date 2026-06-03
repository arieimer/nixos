{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.loupe.enable = mkEnableOption "btop";
  config = mkIf config.cfg.programs.loupe.enable {
    hj.packages = [pkgs.loupe];
    xdg.mime.defaultApplications."image/*" = "org.gnome.Loupe.desktop";
  };
}
