{
  inputs,
  self,
  ...
}:
let
  inherit (inputs.nixpkgs.lib) genAttrs nixosSystem filterAttrs;
  inherit (builtins) attrNames readDir;

  dirs = filterAttrs (_: type: type == "directory") (readDir ./.);
  mkSystem = hostName:
    nixosSystem {
      specialArgs = {
        inherit inputs self hostName;
      };
      modules = [
        self.nixosModules.default
        ./${hostName}/hardware-configuration.nix
        ./${hostName}/options.nix
      ];
    };
in
{
  flake.nixosConfigurations = genAttrs (attrNames dirs) mkSystem;
}
