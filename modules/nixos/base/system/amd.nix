{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.cfg.system.amd;
in {
  options.cfg.system.amd.enable = mkEnableOption "amd";
  config = mkIf cfg.enable {
    hj.packages = [pkgs.nvtopPackages.amd];
    services.xserver.videoDrivers = ["amdgpu"];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
