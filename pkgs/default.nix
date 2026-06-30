{lib, ...}: let
  inherit (lib) packagesFromDirectoryRecursive callPackageWith;
in {
  perSystem = {pkgs, ...}: {
    packages = packagesFromDirectoryRecursive {
      callPackage = callPackageWith pkgs;
      directory = ./packages;
    };
  };
}
