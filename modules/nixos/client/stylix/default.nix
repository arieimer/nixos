{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  options.cfg.stylix.image = lib.mkOption {
    type = lib.types.str;
    default = "austria_landscape";
    description = "Name of the wallpaper";
  };
  config = lib.mkIf config.cfg.stylix.enable {
    # client stylix conf
    fonts.packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-emoji
      pkgs.noto-fonts-cjk-sans
      pkgs.corefonts
    ];
    stylix = {
      cursor.size = 20;
      image = "${inputs.wallpapers}/${config.cfg.stylix.image}.png";
      cursor.name = "Bibata-Modern-Ice";
      cursor.package = pkgs.bibata-cursors;
      fonts = {
        serif = {
          package = inputs.apple-fonts.packages.${pkgs.system}.ny;
          name = "New York Medium";
        };
        sansSerif = {
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro;
          name = "SF Pro Text";
        };
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
      };
    };
  };
}
