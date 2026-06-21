{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types attrNames;
  cfg = config.cfg.system.kernel;
  kernels = {
    "latest" = pkgs.linuxPackages_latest;
    "lts" = pkgs.linuxPackages;
    "zen" = pkgs.linuxPackages_zen;
    "cachyos" = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
    "cachyos-v2" = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v2; # no binary cache
    "cachyos-v3" = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
    "cachyos-v4" = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v4;
    "cachyos-zen4" = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-86_64-zen4;
  };
  kernelType = kernels.${cfg.type}
    or (throw "Unknown kernel: ${cfg.type}");
in {
  options.cfg.system.kernel = {
    type = mkOption {
      type = types.enum (attrNames kernels);
      default = "latest";
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
      enable = cfg.scx.enable;
      scheduler = cfg.scx.scheduler;
    };
    boot = {
      kernelPackages = kernelType;
      kernel.sysctl."vm.max_map_count" = 2147483642;
    };
  };
}
