{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
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
    authorizedKeys = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };
  config = {
    services.automatic-timezoned.enable = true;
    users = {
      mutableUsers = false;
      users.${cfg.username} = {
        isNormalUser = true;
        hashedPassword = "$2b$05$.i8mAte0MIo.hsItMvWSge6VYE/K1ejh5ZnjPq7D698BD7dyxWXEK"; # Oh so temporary
        extraGroups =
          [
            "wheel"
          ]
          ++ cfg.extraGroups;
        openssh.authorizedKeys.keys = cfg.authorizedKeys;
      };
    };
  };
}
