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
    virtualisation = {
      podman = {
        enable = true;
        dockerSocket.enable = true;
      };
      oci-containers.backend = "podman";
    };
  };
}
