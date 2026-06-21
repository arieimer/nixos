{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.loupe;
in {
  options.cfg.programs.loupe.enable = mkEnableOption "loupe";
  config = mkIf cfg.enable {
    hj.packages = [pkgs.loupe];
    xdg.mime.defaultApplications."image/*" = "org.gnome.Loupe.desktop";
  };
}
