{
  hostName,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.cfg.system.networkmanager;
in {
  options.cfg.system.networkmanager.enable = mkEnableOption "networkmanager";
  config = {
    networking = {
      networkmanager.enable = cfg.enable;
      inherit hostName;
    };
  };
}
