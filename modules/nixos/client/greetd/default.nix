{
  lib,
  pkgs,
  config,
  ...
}:
let
  cmd = "uwsm start hyprland-uwsm.desktop";
in
{
  options.cfg.greetd.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables greetd with tuigreet for login";
  };
  config = lib.mkIf config.cfg.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
          ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --greeting 'test test asdfasdf' \
            --time \
            --remember \
            --cmd 'fish -c "uwsm start hyprland-uwsm.desktop"'
          '';
          user = "greeter";
        };
      };
    };
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
