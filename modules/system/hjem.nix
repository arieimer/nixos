{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib) modules;
in {
  imports = [
    inputs.hjem.nixosModules.default
    (modules.mkAliasOptionModule ["hj"] ["hjem" "users" config.cfg.user.username])
  ];
  config = {
    hjem = {
      clobberByDefault = true;
      users.${config.cfg.user.username} = {
        enable = true;
      };
    };
  };
}
