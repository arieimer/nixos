{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.decibels;
in {
  options.cfg.programs.decibels.enable = mkEnableOption "decibels";
  config = mkIf cfg.enable {
    hj.packages = [pkgs.decibels];
    xdg.mime.defaultApplications."audio/*" = "org.gnome.Decibels.desktop";
  };
}
