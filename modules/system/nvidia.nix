{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
in {
  options.cfg.system.nvidia.enable = mkEnableOption "nvidia";
  config = mkIf config.cfg.system.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia = {
        open = true;
        powerManagement.enable = true;
        nvidiaSettings = false;
        branch = "bleeding_edge";
        moduleParams = {
          nvidia = {
            NVreg_UsePageAttributeTable = 1;
            NVreg_EnableResizableBar = 1;
          };
        };
      };
    };
    environment.sessionVariables = {
      __GL_SYNC_TO_VBLANK = "0";
      __GL_VRR_ALLOWED = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
