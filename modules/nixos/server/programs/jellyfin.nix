{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.jellyfin;
in {
  options.cfg.programs.jellyfin.enable = mkEnableOption "jellyfin";
  config = mkIf cfg.enable {
    cfg.system.caddy.proxies.jellyfin.port = 8096;
    cfg.programs.gatus.endpoint.Jellyfin.url = "https://jellyfin.arieimer.net";
    services.jellyfin = {
      enable = true;
      hardwareAcceleration = {
        enable = true;
        type = "vaapi";
        device = "/dev/dri/renderD128";
      };
      forceEncodingConfig = true;
      transcoding = {
        enableHardwareEncoding = true;

        hardwareDecodingCodecs = {
          h264 = true;
          hevc = true;
          vp8 = true;
          vp9 = true;
          av1 = true;
        };
        hardwareEncodingCodecs.hevc = true;
        enableToneMapping = true;
        encodingPreset = "auto";
      };
    };
    systemd.tmpfiles.rules = [
      "d /srv/tampa/media 02775 root media -"
      # "d /srv/media/Movies 02775 jellyfin media -"
      # "d /srv/media/TV 02775 jellyfin media -"
      "d /srv/tampa/media/Music 02775 jellyfin media -"
    ];
    users.groups.media = {};
    users.users.jellyfin.extraGroups = ["render" "video" "media"];
  };
}
