{
  osConfig,
  lib,
  ...
}:
{
  config = lib.mkIf (osConfig.cfg.gpu.type == "nvidia") {
    wayland.windowManager.hyprland.settings = {
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"
        "GBM_BACKEND,nvidia-drm"
        #"ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];
    };
  };
}
