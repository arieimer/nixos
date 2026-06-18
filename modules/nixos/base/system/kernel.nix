{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  kernelType =
    if config.cfg.system.kernel == "latest"
    then pkgs.linuxPackages_latest
    else if config.cfg.system.kernel == "lts"
    then pkgs.linuxPackages
    else if config.cfg.system.kernel == "zen"
    then pkgs.linuxPackages_zen
    else if config.cfg.system.kernel == "cachyos"
    then pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto
    else if config.cfg.system.kernel == "cachyos-v3"
    then pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3
    else throw "unknown kernel type.";
in {
  options.cfg.system = {
    kernel = mkOption {
      type = types.enum [
        "latest"
        "lts"
        "zen"
        "cachyos"
        "cachyos-v3"
      ];
      default = "lts";
    };
    scx = {
      enable = mkEnableOption "scx";
      scheduler = mkOption {
        type = types.str;
        default = "scx_lavd";
      };
    };
  };
  config = {
    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
    ];
    nix.settings.substituters = ["https://attic.xuyh0120.win/lantian"];
    nix.settings.trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];
    services.scx = {
      enable = config.cfg.system.scx.enable;
      scheduler = config.cfg.system.scx.scheduler;
    };
    boot = {
      kernelPackages = kernelType;
      kernel.sysctl."vm.max_map_count" = 2147483642;
    };
  };
}
