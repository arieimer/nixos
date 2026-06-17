{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.obs.enable = mkEnableOption "obs";
  config = mkIf config.cfg.programs.obs.enable {
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
