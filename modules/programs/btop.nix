{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.btop.enable = mkEnableOption "btop";
  config = mkIf config.cfg.programs.btop.enable {
    hj = {
      packages = [
        pkgs.btop
      ];
      xdg.config.files."btop/btop.conf".text = ''
        color_theme = "noctalia.theme"
      '';
    };
  };
}
