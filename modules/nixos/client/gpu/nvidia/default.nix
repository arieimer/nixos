{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.cfg.gpu.nvidia.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Installs nvidia GPU drivers (open kernel modules)";
  };
  config = lib.mkIf config.cfg.gpu.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
      nvidia = {
        open = true;
        nvidiaSettings = false;
        package = config.boot.kernelPackages.nvidiaPackages.beta;  
      };
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = [
          pkgs.nvidia-vaapi-driver
        ];
      };
    };
  };
}
