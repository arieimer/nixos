{
  config,
  hostName,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.cfg.system.nix;
in {
  options.cfg.system.nix.hostName = mkOption {
    type = types.str;
    default = hostName;
    description = "The hostname for this Darwin system.";
  };

  config = {
    networking.hostName = cfg.hostName;
    nixpkgs.hostPlatform = "aarch64-darwin";

    nix = {
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    environment.systemPackages = [pkgs.nh];
    environment.variables.NH_DARWIN_FLAKE = "${config.cfg.user.home}/.config/nixos";
  };
}
