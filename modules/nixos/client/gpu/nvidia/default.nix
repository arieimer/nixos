{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf ((config.cfg.gpu.type == "nvidia") && config.cfg.gpu.enable) {
    environment.systemPackages = [
      pkgs.nvtopPackages.nvidia
    ];
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
