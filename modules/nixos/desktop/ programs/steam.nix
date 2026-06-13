{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.steam.enable = mkEnableOption "steam";
  config = mkIf config.cfg.programs.steam.enable {
    cfg.preservation.directories = [".local/share/Steam" ".steam"];
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };
}
