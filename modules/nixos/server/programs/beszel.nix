{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.beszel;
in {
  options.cfg.programs.beszel.enable = mkEnableOption "beszel";
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      beszel = {
        image = "henrygd/beszel:latest";
        extraOptions = [
          "--network=host"
          "--health-cmd=/beszel health --url http://localhost:8090"
          "--health-start-period=5s"
          "--health-interval=120s"
        ];
        environment.APP_URL = "http://localhost:8090";
        volumes = [
          "/home/${config.cfg.user.username}/Beszel:/beszel_data"
        ];
        autoStart = true;
      };
      beszel-agent = {
        image = "henrygd/beszel-agent:latest";
        extraOptions = [
          "--network=host"
          "--health-cmd=/agent health"
          "--health-interval=120s"
        ];
        environment = {
          KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO5GUo9qVw1Kolw87G1NCOfuKF3rrs3vLBBPoXbaRAVg";
          Token = "8ae40e6c-17cf-4e22-979b-4ee94e1172e0";
          HUB_URL = "http://localhost:8090";
          LISTEN = "45876";
          DOCKER_HOST = "unix:///run/podman/podman.sock";
        };
        volumes = [
          "/run/podman/podman.sock:/run/podman/podman.sock:ro"
        ];
      };
    };
    cfg.preservation.homeDirectories = ["Beszel"];
  };
}
