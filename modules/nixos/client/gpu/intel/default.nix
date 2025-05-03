{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = lib.mkIf ((config.cfg.gpu.type == "intel") && config.cfg.gpu.enable) {
    environment.systemPackages = [
      pkgs.nvtopPackages.intel
    ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
