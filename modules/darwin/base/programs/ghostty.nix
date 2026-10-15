{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf generators;
  cfg = config.cfg.programs.ghostty;
in {
  options.cfg.programs.ghostty.enable = mkEnableOption "ghostty";

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.ghostty-bin];
    hj = {
      xdg.config.files."ghostty/config.ghostty" = {
        generator = generators.toKeyValue {};
        value = {
          confirm-close-surface = false;
          working-directory = "home";
        };
      };
      files.".ssh/config".text = ''
        Host *
        SetEnv TERM=xterm-256color
      '';
    };
  };
}
