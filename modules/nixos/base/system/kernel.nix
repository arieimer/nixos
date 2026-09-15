{
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
