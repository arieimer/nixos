{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.cider;
in {
  options.cfg.programs.cider.enable = mkEnableOption "cider";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".config/sh.cider.genten"];
    hj.packages = [pkgs.cider-2];
  };
}
