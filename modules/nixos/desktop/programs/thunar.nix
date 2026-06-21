{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf concatMapStrings;
  cfg = config.cfg.programs.thunar;
  bookmarks = [
    "file:///home/${config.cfg.user.username}/Downloads Downloads"
    "file:///home/${config.cfg.user.username}/Documents Documents"
    "file:///home/${config.cfg.user.username}/Pictures Pictures"
  ];
in {
  options.cfg.programs.thunar.enable = mkEnableOption "thunar";
  config = mkIf cfg.enable {
    programs.thunar = {
      enable = true;
      plugins = [
        pkgs.thunar-archive-plugin
      ];
    };
    services.tumbler.enable = true;
    hj = {
      packages = [
        pkgs.p7zip
        pkgs.unrar
        pkgs.file-roller
      ];
      xdg.config.files."gtk-3.0/bookmarks".text = concatMapStrings (l: l + "\n") bookmarks;
    };
    xdg.mime.defaultApplications = {
      "inode/directory" = "thunar.desktop";

      "application/zip" = "org.gnome.FileRoller.desktop";
      "application/vnd.rar" = "org.gnome.FileRoller.desktop";
      "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
      "application/x-tar" = "org.gnome.FileRoller.desktop";
      "application/gzip" = "org.gnome.FileRoller.desktop";
      "application/x-bzip" = "org.gnome.FileRoller.desktop";
      "application/x-bzip2" = "org.gnome.FileRoller.desktop";
      "application/x-xz" = "org.gnome.FileRoller.desktop";
      "application/x-rar-compressed" = "org.gnome.FileRoller.desktop";
    };
  };
}
