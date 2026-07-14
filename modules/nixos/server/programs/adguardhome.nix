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
    services.adguardhome = {
      enable = true;
      mutableSettings = false;
      settings = {
        http = {
          address = "100.112.194.46:3000";
        };
        dns = {
          bind_hosts = [
            "100.112.194.46"
          ];
          bootstrap_dns = [
            "9.9.9.10"
            "149.112.112.112"
            "1.1.1.1"
            "2620:fe::fe"
          ];
          port = 53;
        };
      };
    };
    systemd.services.adguardhome = {
      after = ["tailscaled.service" "network-online.target"];
      wants = ["tailscaled.service" "network-online.target"];
    };
    cfg.preservation.directories = [
      {
        directory = "/var/lib/AdGuardHome";
        user = "adguardhome";
      }
    ];
  };
}
