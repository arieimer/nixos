{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.mpv;
in {
  options.cfg.programs.mpv.enable = mkEnableOption "mpv";
  config = mkIf cfg.enable {
    hj.packages = [pkgs.mpv];
    xdg.mime.defaultApplications = {
      "video/*" = "mpv.desktop";
      "audio/*" = "mpv.desktop";
    };
  };
}
