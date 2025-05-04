{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.cfg.gui.fcitx5.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Installs fcitx5 input and the mozc addon (日本語)";
  };
  config = lib.mkIf config.cfg.gui.fcitx5.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = [ pkgs.fcitx5-mozc-ut ];
        settings = {
          inputMethod = {
            GroupOrder."0" = "Default";
              "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "mozc";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "mozc";
          };
        };
      };
    };
  };
}
