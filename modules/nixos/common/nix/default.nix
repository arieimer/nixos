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
        warn-dirty = false;
        allowed-users = [ "@wheel" ];
        trusted-users = [ "@wheel" ];
      };
    };
    nixpkgs.config.allowUnfree = true;
    system.rebuild.enableNg = true;
    programs.nh = {
      enable = true;
      flake = "/home/${username}/.config/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep 8 --keep-since 7d";
      };
    };
  };
}
