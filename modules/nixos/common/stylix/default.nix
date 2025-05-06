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
    default = "catppuccin-mocha";
    description = "chooses which color scheme to use";
  };

  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  config = lib.mkIf config.cfg.stylix.enable {
    # common stylix conf
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.cfg.stylix.scheme}.yaml";
    };
  };
}
