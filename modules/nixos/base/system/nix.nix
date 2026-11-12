{config, ...}: {
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
    documentation = {
      enable = false;
      nixos.enable = false;
      man.enable = false;
      doc.enable = false;
      info.enable = false;
    };
    environment.defaultPackages = [];
    programs.command-not-found.enable = false;
    nix = {
      channel.enable = false;
      settings = {
        extra-substituters = ["https://cache.numtide.com"];
        extra-trusted-public-keys = [
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];
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
