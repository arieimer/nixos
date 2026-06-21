{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.obs;
in {
  options.cfg.programs.obs.enable = mkEnableOption "obs";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".config/obs-studio"];
    programs.obs-studio = {
      enable = true;
      plugins = [
        pkgs.obs-studio-plugins.obs-pipewire-audio-capture
        pkgs.obs-studio-plugins.obs-vkcapture
      ];
    };
  };
}
