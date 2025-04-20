{
  nixpkgs,
  ...
}@inputs:
let
  username = "ari";
in
{
  formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
  nixosConfigurations = {
    detlas = nixpkgs.lib.nixosSystem {
      specialArgs = {
        hostname = "detlas";
        system = "x86_64-linux";
        inherit
          inputs
          username
          ;
      };
      modules = [
        ./detlas
        ../modules/nixos/common
        ../modules/nixos/client
      ];
    };
    selchar = nixpkgs.lib.nixosSystem {
      specialArgs = {
        hostname = "selchar";
        system = "x86_64-linux";
        inherit
          inputs
          username
          ;
      };
      modules = [
        ./selchar
        ../modules/nixos/common
      ];
    };
  };
}
