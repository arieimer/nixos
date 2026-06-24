{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.udiskie;
in {
  options.cfg.system.udiskie.enable = mkEnableOption "udiskie";
  config = mkIf cfg.enable {
    services.udisks2.enable = true;
    hj.packages = [pkgs.udiskie];
  };
}
