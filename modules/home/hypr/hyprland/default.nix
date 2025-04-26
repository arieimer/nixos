{
  lib,
  config,
  ...
}:
{
  options.cfg.hypr.hyprland.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Configures hyprland";
  };
  options.cfg.hypr.hyprland.sensitivity = lib.mkOption {
    type = lib.types.str;
    default = "-2";
    description = "Hyprland mouse sensitivity";
  };

  imports = [
    ./monitors.nix
    ./workspaces.nix
    ./binds.nix
    ./nvidia.nix
  ];

  config = lib.mkIf config.cfg.hypr.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        input = {
          inherit (config.cfg.hypr.hyprland) sensitivity;
        };
        general = {
          gaps_out = 4;
          gaps_in = 2;
          border_size = 2;
        };
        misc = {
          disable_splash_rendering = 1;
        };
      };
    };
  };
}
