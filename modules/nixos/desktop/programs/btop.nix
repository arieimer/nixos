{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf generators;
in {
  options.cfg.programs.btop.enable = mkEnableOption "btop";
  config = mkIf config.cfg.programs.btop.enable {
    hj = {
      packages = [
        pkgs.btop
      ];
      xdg.config.files."btop/btop.conf" = {
        generator = generators.toKeyValue {};
        value.color_theme = "noctalia.theme";
      };
    };
  };
}
