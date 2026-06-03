{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.greetd.enable = mkEnableOption "greetd";
  config = mkIf config.cfg.system.greetd.enable {
    # preservation.preserveAt."/persistent".directories = [ "/var/cache/tuigreet" ];
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.tuigreet}/bin/tuigreet \
            --greeting "Welcome back.." \
            --time \
            --time-format "%B %-d %I:%M %p" \
            --remember \
            --asterisks \
            --cmd 'niri'
          '';
          user = "greeter";
        };
      };
    };
  };
}
