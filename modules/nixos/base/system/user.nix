{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
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
    authorizedKeys = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };
  config = {
    services.automatic-timezoned.enable = true;
    users = {
      mutableUsers = true;
      users.${config.cfg.user.username} = {
        isNormalUser = true;
        initialPassword = "1234";
        extraGroups =
          [
            "wheel"
          ]
          ++ config.cfg.user.extraGroups;
      };
    };
  };
}
