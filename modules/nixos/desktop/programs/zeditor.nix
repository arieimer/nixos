{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.zeditor;
in {
  options.cfg.programs.zeditor.enable = mkEnableOption "zeditor";
  config = mkIf cfg.enable {
    hj.packages = [pkgs.zed-editor];
  };
}
