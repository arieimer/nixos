{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.prismlauncher.enable = mkEnableOption "prismlauncher";
  config = mkIf config.cfg.programs.prismlauncher.enable {
    hj = {
      packages = [
        (pkgs.prismlauncher.override {
          jdks = [
            pkgs.temurin-jre-bin-8
            pkgs.temurin-jre-bin-17
            pkgs.temurin-jre-bin-21
            pkgs.temurin-jre-bin-25
          ];
        })
      ];
    };
  };
}
