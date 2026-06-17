{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.fcitx5.enable = mkEnableOption "fcitx5";
  config = mkIf config.cfg.programs.fcitx5.enable {
    environment.sessionVariables.XMODIFIERS = "@im=fcitx";
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = [
          pkgs.fcitx5-mozc
        ];
        settings = {
          globalOptions."Hotkey/TriggerKeys"."0" = "Alt+space";
          addons = {
            quickphrase.globalSection.TriggerKey = "";
            clipboard.globalSection.TriggerKey = "";
            unicode.globalSection.TriggerKey = "";
          };
          inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "keyboard-us";
              DefaultIM = "mozc";
            };
            "Groups/0/Items/0" = {
              Name = "keyboard-us";
              Layout = "";
            };
            "Groups/0/Items/1" = {
              Name = "mozc";
              Layout = "";
            };
            GroupOrder = {
              "0" = "Default";
            };
          };
        };
      };
    };
  };
}
