{
  hostName,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption;
in {
  options.cfg.system.networkmanager.enable = mkEnableOption "networkmanager";
  config = {
    networking = {
      networkmanager.enable = config.cfg.system.networkmanager.enable;
      inherit hostName;
    };
  };
}
