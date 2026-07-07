{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.podman;
in {
  options.cfg.system.podman.enable = mkEnableOption "podman";
  config = mkIf cfg.enable {
    cfg.preservation.directories = ["/var/lib/containers"];
    virtualisation = {
      podman = {
        enable = true;
        # defaultNetwork.settings.dns_enabled = true; # currently uncessecary
      };
      oci-containers.backend = "podman";
    };
  };
}
