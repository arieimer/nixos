{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.mpv.enable = mkEnableOption "mpv";
  config = mkIf config.cfg.programs.mpv.enable {
    hj.packages = [pkgs.mpv];
    xdg.mime.defaultApplications = {
      "video/*" = "mpv.desktop";
      "audio/*" = "mpv.desktop";
    };
  };
}
