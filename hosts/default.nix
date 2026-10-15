{
  inputs,
  self,
  ...
}: let
  inherit (inputs.nixpkgs.lib) genAttrs nixosSystem filterAttrs;
  inherit (builtins) attrNames readDir;

  linuxDirs = filterAttrs (_: type: type == "directory") (readDir ./linux);
  darwinDirs = filterAttrs (_: type: type == "directory") (readDir ./darwin);
  mkLinux = hostName:
    nixosSystem {
      specialArgs = {
        inherit inputs self hostName;
      };
      modules = [
        ./linux/${hostName}/config.nix
        ./linux/${hostName}/hardware.nix
      ];
    };
  mkDarwin = hostName:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs self hostName;
      };
      modules = [./darwin/${hostName}/darwin.nix];
    };
in {
  flake.nixosConfigurations = genAttrs (attrNames linuxDirs) mkLinux;
  flake.darwinConfigurations = genAttrs (attrNames darwinDirs) mkDarwin;
}
