{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.paperless;
in {
  options.cfg.programs.paperless.enable = mkEnableOption "paperless";
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      paperless-broker = {
        image = "docker.io/library/redis:8";
        extraOptions = ["--network=paperless"];
        volumes = [
          "/home/${config.cfg.user.username}/Paperless/redisdata:/data"
        ];
      };
      paperless-db = {
        image = "docker.io/library/postgres:18";
        extraOptions = ["--network=paperless"];
        volumes = [
          "/home/${config.cfg.user.username}/Paperless/pgdata:/var/lib/postgresql"
        ];
        environment = {
          POSTGRES_DB = "paperless";
          POSTGRES_USER = "paperless";
          POSTGRES_PASSWORD = "paperless";
        };
      };
      paperless-webserver = {
        image = "ghcr.io/paperless-ngx/paperless-ngx:latest";
        dependsOn = ["paperless-db" "paperless-broker"];
        ports = ["8000:8000"];
        volumes = [
          "/home/${config.cfg.user.username}/Paperless/data:/usr/src/paperless/data"
          "/home/${config.cfg.user.username}/Paperless/media:/usr/src/paperless/media"
          "/home/${config.cfg.user.username}/Paperless/export:/usr/src/paperless/export"
          "/home/${config.cfg.user.username}/Paperless/consume:/usr/src/paperless/consume"
        ];
        environment = {
          PAPERLESS_REDIS = "redis://paperless-broker:6379";
          PAPERLESS_DBHOST = "paperless-db";
          USERMAP_UID = "1000";
          USERMAP_GID = "1000";
          PAPERLESS_URL = "https://paperless.arieimer.net";
          PAPERLESS_TIME_ZONE = "America/Chicago";
          PAPERLESS_OCR_LANGUAGE = "eng";
          PAPERLESS_OCR_LANGUAGES = "eng jpn";
        };
        extraOptions = ["--network=paperless"];
      };
    };
    systemd.services.podman-network-paperless = {
      serviceConfig.Type = "oneshot";
      wantedBy = ["multi-user.target"];
      script = ''
        ${pkgs.podman}/bin/podman network exists paperless || \
          ${pkgs.podman}/bin/podman network create paperless
      '';
    };
    systemd.services.podman-paperless-broker.after = ["podman-network-paperless.service"];
    systemd.services.podman-paperless-broker.requires = ["podman-network-paperless.service"];
    systemd.services.podman-paperless-db.after = ["podman-network-paperless.service"];
    systemd.services.podman-paperless-db.requires = ["podman-network-paperless.service"];
    systemd.services.podman-paperless-webserver.after = ["podman-network-paperless.service"];
    systemd.services.podman-paperless-webserver.requires = ["podman-network-paperless.service"];
    cfg.preservation.homeDirectories = [
      "Paperless/redisdata"
      "Paperless/pgdata"
      "Paperless/data"
      "Paperless/media"
      "Paperless/export"
      "Paperless/consume"
    ];
  };
}
