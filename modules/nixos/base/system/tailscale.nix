{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.tailscale.enable = mkEnableOption "tailscale";
  config = mkIf config.cfg.system.tailscale.enable {
    cfg.preservation.directories = ["/var/lib/tailscale"];
    services.tailscale = {
      enable = true;
      authKeyFile = config.sops.secrets.tailscale.path;
      openFirewall = true;
    };
  };
}
