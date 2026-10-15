{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf generators;
  cfg = config.cfg.programs.btop;
in {
  options.cfg.programs.btop.enable = mkEnableOption "btop";

  config = mkIf cfg.enable {
    hj.packages = [pkgs.btop];
  };
}
