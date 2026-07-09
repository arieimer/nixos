{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.dns;
in {
  options.cfg.system.dns.enable = mkEnableOption "dns";
  config = mkIf cfg.enable {
    networking.nameservers = ["100.112.194.46"];
    services.resolved = {
      enable = true;
      settings.Resolve = {
        domains = ["~."];
        fallbackDns = [
          "1.1.1.1"
          "1.0.0.1"
          "9.9.9.9"
        ];
      };
    };
  };
}
