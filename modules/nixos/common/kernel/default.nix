{
  config,
  pkgs,
  lib,
  ...
}:
let
  kernelType =
    if config.cfg.kernel.type == "zen"
    then pkgs.linuxKernel.packages.linux_zen
    else if config.cfg.kernel.type == "lts"
    then pkgs.linuxKernel
    else if config.cfg.kernel.type == "latest"
    then pkgs.linuxPackages_latest
    else if config.cfg.kernel.type == "xanmod_latest"
    then pkgs.linuxKernel.packaes.linux_xanmod_latest
    else throw "Invalid kernel type try zen, lts, latest, or xanmod_latest";
in
{
  options.cfg.kernel.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Sets kernel";
  };
  options.cfg.kernel.type = lib.mkOption {
    type = lib.types.enum [
      "latest"
      "lts"
      "zen"
      "xanmod_latest"
    ];
    default = "latest";
    description = "Selects which kernel needs to be used ex: 'zen' or 'latest'";
  };
  config = lib.mkIf config.cfg.kernel.enable {
    boot.kernelPackages = kernelType;
  };
}

