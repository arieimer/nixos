{
  system,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    ./configuration.nix
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];
  nixpkgs.hostPlatform = "${system}";
}
