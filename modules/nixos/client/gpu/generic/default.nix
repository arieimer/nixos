{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf (!config.cfg.gpu.nvidia.enable) {
    boot.initrd.kernelModules = [ "amdgpu" ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
