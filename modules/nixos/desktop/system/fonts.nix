{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.fonts;
in {
  options.cfg.system.fonts.enable = mkEnableOption "fonts";
  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;
      fontconfig = {
        includeUserConf = false;
        defaultFonts = {
          serif = [
            "Noto Serif"
          ];
          sansSerif = [
            "Inter Variable"
          ];
          monospace = [
            "Symbols Nerd Font Mono"
            "Lilex Nerd Font Mono"
          ];
          emoji = [
            "Noto Color Emoji"
          ];
        };
      };
      packages = with pkgs; [
        nerd-fonts.symbols-only
        noto-fonts
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
        vista-fonts
        inter
        nerd-fonts.lilex
      ];
    };
  };
}
