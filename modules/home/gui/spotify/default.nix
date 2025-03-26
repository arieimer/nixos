{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  options.cfg.gui.spotify.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures spotify with spicetify";
  };
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  config = lib.mkIf config.cfg.gui.spotify.enable {
    programs.spicetify = {
      enable = true;
      enabledExtensions = [
        inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions.adblock
      ];
    };
  };
}
