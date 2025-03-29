{
  inputs,
  username,
  hostname,
  system,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    users.${username} = import ./import.nix;
    extraSpecialArgs = {
      inherit
        inputs
        username
        hostname
        system
        ;
    };
  };
}
