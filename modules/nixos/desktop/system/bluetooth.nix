{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.bluetooth.enable = mkEnableOption "bluetooth";
  config = mkIf config.cfg.system.bluetooth.enable {
    hardware.bluetooth.enable = true;
  };
}
