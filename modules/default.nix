{lib, ...}: let
  inherit (lib) filesystem hasSuffix hasPrefix;
  collectNixModules = dir: let
    allNixFiles = filesystem.listFilesRecursive dir;
    filterFile = path: let
      name = baseNameOf path;
    in
      path
      != ./default.nix
      && hasSuffix ".nix" name
      && ! hasPrefix "_" name;
  in
    builtins.filter filterFile allNixFiles;
in {
  flake.nixosModules.default.imports = collectNixModules ./.;
}
