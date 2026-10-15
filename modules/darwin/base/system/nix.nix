{pkgs, ...}: {
  networking.hostName = "saitama";
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix = {
    package = pkgs.lix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
