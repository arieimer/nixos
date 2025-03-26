{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.cfg.gui.heroic.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs Heroic Games Launcher";
  };
  options.cfg.gui.lutris.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Installs Lutris";
  };
  options.cfg.gui.prismlauncher.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs Prism Launcher";
  };
  options.cfg.gui.suyu.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Installs suyu emulator";
  };

  config = lib.mkIf true {
    home.packages = lib.mkMerge [
      (lib.mkIf config.cfg.gui.heroic.enable [
        pkgs.heroic
      ])
      (lib.mkIf config.cfg.gui.lutris.enable [
        pkgs.lutris
      ])
      (lib.mkIf config.cfg.gui.suyu.enable [
        pkgs.suyu
      ])
      (lib.mkIf config.cfg.gui.prismlauncher.enable [
        (pkgs.prismlauncher.override {
          jdks = [
            pkgs.temurin-jre-bin-8
            pkgs.temurin-jre-bin-17
            pkgs.temurin-jre-bin-21
          ];
        })
      ])
    ];
  };
}
