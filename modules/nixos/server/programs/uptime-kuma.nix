{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.uptime-kuma;
in {
  options.cfg.programs.uptime-kuma.enable = mkEnableOption "uptime-kuma";
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers.uptime-kuma = {
      image = "louislam/uptime-kuma:2";
      extraOptions = [
        "--network=host"
      ];
      volumes = [
        "/home/${config.cfg.user.username}/Uptime-kuma/data:/data"
      ];
      autoStart = true;
    };
    cfg.preservation.homeDirectories = [
      "Uptime-kuma/data"
    ];
  };
}
