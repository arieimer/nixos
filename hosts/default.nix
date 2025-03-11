{
  nixpkgs,
  ...  
}@inputs:
let
  username = "ari";
in
{
  nixosConfigurations = {
    detlas = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        hostname = "detlas";
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
  };
}
