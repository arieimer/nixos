{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  config = {
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
        "password".neededForUsers = true;
        "tailscale" = {};
      };
    };
  };
}
