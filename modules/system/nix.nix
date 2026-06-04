{
  config,
  ...
}: {
  config = {
    programs.nh = {
      enable = true;
      flake = "/home/${config.cfg.user.username}/.config/nixos";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep ${toString config.boot.loader.systemd-boot.configurationLimit}";
      };
    };
    documentation.nixos.enable = false;
    programs.command-not-found.enable = false;
    nix = {
      channel.enable = false;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = true;
        warn-dirty = false;
        download-buffer-size = 1024 * 1024 * 1024;
        allowed-users = ["@wheel"];
        trusted-users = ["@wheel"];
      };
    };
    nixpkgs.config.allowUnfree = true;
  };
}
