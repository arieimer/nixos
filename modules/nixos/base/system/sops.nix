{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.sops;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  options.cfg.system.sops.enable = mkEnableOption "sops";
  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/sops/age/keys.txt";
      age.sshKeyPaths = [];
      secrets = {
        "git_ssh_key" = {
          owner = config.cfg.user.username;
          path = "/home/${config.cfg.user.username}/.ssh/id_ed25519";
        };
        "mullvad".owner = config.cfg.user.username;
        "tailscale" = {}; # propogates it
      };
    };
  };
}
