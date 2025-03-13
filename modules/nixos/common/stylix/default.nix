{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
{
  options.cfg.stylix.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs stylix";
  };
  options.cfg.stylix.scheme = lib.mkOption {
    type = lib.types.str;
    default = "ayu-dark";
    description = "chooses which color scheme to use";
  };
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  config = lib.mkIf config.cfg.stylix.enable {
    fonts.packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-emoji
      pkgs.noto-fonts-cjk-sans
      pkgs.corefonts
    ];
    stylix = {
      enable = true;
      cursor.size = 20;
      polarity = "dark"; # Probably not required
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.cfg.stylix.scheme}.yaml";
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
          package = pkgs.nerd-fonts.space-mono;
          name = "SpaceMono Nerd Font";
        };
      };
    };
  };
}
