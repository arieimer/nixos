{config, lib, ...}: let
  inherit (lib) mkOption types;
  cfg = config.cfg.user;
in {
  options.cfg.user = {
    username = mkOption {
      type = types.str;
      default = "ari";
    };
    home = mkOption {
      type = types.str;
      default = "/Users/${cfg.username}";
    };
  };

  config = {
    system.primaryUser = cfg.username;
    users.users.${cfg.username}.home = cfg.home;
  };
}
