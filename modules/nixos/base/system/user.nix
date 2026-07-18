{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types mkIf;
  cfg = config.cfg.user;
in {
  options.cfg.user = {
    username = mkOption {
      type = types.str;
      default = "a-nixos-user";
    };
    extraGroups = mkOption {
      type = types.listOf types.str;
      default = [];
    };
    timeZone = mkOption {
      type = types.str;
      default = "auto";
    };
  };
  config = {
    services.automatic-timezoned.enable = config.cfg.user.timeZone == "auto";
    time.timeZone = mkIf (config.cfg.user.timeZone != "auto") config.cfg.user.timeZone;
    users = {
      mutableUsers = false;
      users.${cfg.username} = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.password.path;
        extraGroups =
          [
            "wheel"
          ]
          ++ cfg.extraGroups;
      };
    };
  };
}
