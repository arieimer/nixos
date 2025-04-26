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
      fcitx5.waylandFrontend = true;
      fcitx5.addons = [ pkgs.fcitx5-mozc-ut ];
    };
  };
}
