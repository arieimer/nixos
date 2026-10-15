{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (lib) modules;
in {
  imports = [
    inputs.hjem.darwinModules.default
    (modules.mkAliasOptionModule ["hj"] ["hjem" "users" config.cfg.user.username])
  ];

  config = {
    hjem = {
      clobberByDefault = true;
      users.${config.cfg.user.username} = {
        enable = true;
        directory = config.cfg.user.home;
      };
    };
  };
}
