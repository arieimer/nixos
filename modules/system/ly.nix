{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.ly.enable = mkEnableOption "ly";
  config = mkIf config.cfg.system.ly.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        clear_password = true;
        brightness_down_key = null;
        brightness_up_key = null;
        hide_version_string = true;
        session_log = null;
      };
    };
  };
}
