{
  lib,
  ...  
}:
let
  inherit (lib) filesystem hasSuffix hasPrefix;
  allNixFiles = filesystem.listFilesRecursive ./.;

  filterFile = path: let
    name = baseNameOf path;
  in
  path
  != ./default.nix
  && hasSuffix ".nix" name
  && ! hasPrefix "_" name;
in
{
  flake.nixosModules.default = {
    imports = builtins.filter filterFile allNixFiles;
  };
}
