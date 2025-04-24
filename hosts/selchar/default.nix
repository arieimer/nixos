{
  system,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    ./configuration.nix
    ../../packages/scripts/installer
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];
  cfg.kernel.enable = false;
  cfg.boot.enable = false;
  nixpkgs.hostPlatform = "${system}";
}
