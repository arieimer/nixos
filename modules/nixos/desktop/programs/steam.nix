{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.steam;
in {
  options.cfg.programs.steam.enable = mkEnableOption "steam";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".local/share/Steam" ".steam"];
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };
}
