{
  lib,
  config,
  username,
  ...
}:
{
  options.cfg.nix.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Configure nix and enables nix-helper (nh)";
  };
  config = lib.mkIf config.cfg.nix.enable {
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = true;
      };
    };

    nixpkgs.config.allowUnfree = true;

    programs.nh = {
      enable = true;
      flake = "/home/${username}/.config/nixos"; # additionally extends out the environment variables $FLAKE to be used by others
      clean = {
        enable = true;
        extraArgs = "--keep 8 --keep-since 7d";
      };
    };
  };
}
