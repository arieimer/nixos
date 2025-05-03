{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = lib.mkIf ((config.cfg.gpu.type == "amd") && config.cfg.gpu.enable) {
    environment.systemPackages = [
      pkgs.nvtopPackages.amd
    ];
    boot.initrd.kernelModules = [ "amdgpu" ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
