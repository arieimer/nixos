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
    ./fcitx5
  ];

  options.cfg.gui.apps.qbit.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs qbittorrent";
  };
  options.cfg.gui.apps.mpv.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs mpv";
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
  options.cfg.gui.apps.anki.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Install anki";
  };
  options.cfg.gui.apps.obsidian.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs obsidian";
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
      (lib.mkIf config.cfg.gui.apps.anki.enable [
        pkgs.anki-bin
      ])
      (lib.mkIf config.cfg.gui.apps.obsidian.enable [
        pkgs.obsidian
      ])
      (lib.mkIf config.cfg.gui.apps.mpv.enable [
        pkgs.mpv
      ])
    ];
  };
}
