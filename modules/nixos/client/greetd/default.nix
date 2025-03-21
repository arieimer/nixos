{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.cfg.greetd.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures ly a display manager.";
  };
  config = lib.mkIf config.cfg.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r -t --asterisks --cmd 'uwsm start -S hyprland-uwsm.desktop'";
        };
      };
    };
  };
}
