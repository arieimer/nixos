{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.heroic;
in {
  options.cfg.programs.heroic.enable = mkEnableOption "heroic";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [
      ".config/heroic"
      "Games"
    ];
    hj = {
      packages = [
        pkgs.heroic
      ];
      xdg.config.files."heroic/tools/proton/GE-Proton".source = pkgs.proton-ge-bin.steamcompattool;
    };
  };
}
