{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.adguardhome;
in {
  options.cfg.programs.adguardhome.enable = mkEnableOption "adguard-home";
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers.adguardhome = {
      image = "adguard/adguardhome";
      extraOptions = [
        "--network=host"
      ];
      volumes = [
        "/home/${config.cfg.user.username}/Adguardhome/work:/opt/adguardhome/work"
        "/home/${config.cfg.user.username}/Adguardhome/conf:/opt/adguardhome/conf"
      ];
      autoStart = true;
    };
    cfg.preservation.homeDirectories = [
      "Adguardhome/work"
      "Adguardhome/conf"
    ];
  };
}
