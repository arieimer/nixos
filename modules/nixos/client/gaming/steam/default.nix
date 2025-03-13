{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cfg.gaming.steam.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.gaming.enable;
    description = "Installs steam with proton-GE";
  };
  config = lib.mkIf config.cfg.gaming.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
