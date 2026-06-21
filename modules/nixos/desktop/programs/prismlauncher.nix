{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.prismlauncher;
in {
  options.cfg.programs.prismlauncher.enable = mkEnableOption "prismlauncher";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".local/share/PrismLauncher"];
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
