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
  flake = {
    nixosModules = {
      base.imports = collectNixModules ./nixos/base;
      desktop.imports = collectNixModules ./nixos/desktop;
      server.imports = collectNixModules ./nixos/server;
      nvf-common = import ./common/programs/nvf/default.nix;
    };
    darwinModules = {
      base.imports = collectNixModules ./darwin/base;
      nvf-common = import ./common/programs/nvf/default.nix;
    };
  };
}
