{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf (!config.cfg.gpu.nvidia.enable) {
    boot.initrd.kernelModules = [ "amdgpu" ]; # Is not generic but fine for now,,,
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
