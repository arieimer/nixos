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
  options.cfg.programs.ghostty.enable = mkEnableOption "ghostty";
  config = mkIf config.cfg.programs.ghostty.enable {
    hj = {
      packages = [
        pkgs.ghostty
      ];
      xdg.config.files."ghostty/config.ghostty".text = ''
        theme = noctalia
        confirm-close-surface = false
      '';
    };
  };
}
