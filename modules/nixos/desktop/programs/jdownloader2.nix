{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.jdownloader2;
in {
  options.cfg.programs.jdownloader2.enable = mkEnableOption "JDownloader 2";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".local/share/jdownloader2"];
    hj.packages = [
      (pkgs.callPackage ../../../../pkgs/packages/jdownloader2.nix {})
    ];
  };
}
