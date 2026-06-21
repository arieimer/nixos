{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.tailscale;
in {
  options.cfg.system.tailscale.enable = mkEnableOption "tailscale";
  config = mkIf cfg.enable {
    cfg.preservation.directories = ["/var/lib/tailscale"];
    services.tailscale = {
      enable = true;
      authKeyFile = config.sops.secrets.tailscale.path;
      openFirewall = true;
      extraUpFlags = ["--ssh"];
    };
  };
}
