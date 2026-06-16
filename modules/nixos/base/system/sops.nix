{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  options.cfg.system.sops.enable = mkEnableOption "sops";
  config = mkIf config.cfg.system.sops.enable {
    systemd.services.mullvad-daemon.postStart = mkIf config.cfg.programs.mullvad.enable (let
      mullvad = config.services.mullvad-vpn.package;
    in ''
      while ! ${mullvad}/bin/mullvad status >/dev/null; do sleep 1; done
        ${mullvad}/bin/mullvad account login \
        "$(cat ${config.sops.secrets.mullvad.path})"
    '');
    sops = {
      defaultSopsFile = ../../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/sops/age/keys.txt";
      age.sshKeyPaths = [];
      secrets."git_ssh_key" = {
        owner = config.cfg.user.username;
        path = "/home/${config.cfg.user.username}/.ssh/id_ed25519";
      };
      secrets."mullvad" = {
        owner = config.cfg.user.username;
      };
    };
  };
}
