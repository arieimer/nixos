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
  };
  config = {
    services.automatic-timezoned.enable = true;
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
