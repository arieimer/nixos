{
  lib,
  config,
  username,
  hostname,
  ...
}:
{
  options.cfg.user.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Sets username, hostname and groups";
  };
  options.cfg.user.group = lib.mkOption { # TODO: lib.types.attrs is not valid for this use case
    type = lib.types.listOf lib.types.str;
    default = [ "wheel" "networkmanager" ];
    description = "Set user's groups";
  };
  config = lib.mkIf config.cfg.user.enable {
    networking.hostName = hostname;
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = config.cfg.user.group;
      uid = 1000;
    };
  };
}
