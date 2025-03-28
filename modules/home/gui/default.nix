{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./foot
    ./nixcord
    ./gaming
    ./spotify
    ./zen
  ];

  options.cfg.gui.apps.qbit.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs qbittorrent";
  };
  options.cfg.gui.apps.bitwarden.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs bitwarden";
  };
  options.cfg.gui.apps.filezilla.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs filezilla";
  };
  options.cfg.gui.apps.pavu.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs pavucontrol";
  };
  config = {
    home.packages = lib.mkMerge [
      (lib.mkIf config.cfg.gui.apps.qbit.enable [
        pkgs.qbittorrent
      ])
      (lib.mkIf config.cfg.gui.apps.bitwarden.enable [
        pkgs.bitwarden-desktop
      ])
      (lib.mkIf config.cfg.gui.apps.filezilla.enable [
        pkgs.filezilla
      ])
      (lib.mkIf config.cfg.gui.apps.pavu.enable [
        pkgs.pavucontrol
      ])
    ];
  };
}
