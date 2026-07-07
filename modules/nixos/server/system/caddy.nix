{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.caddy;
in {
  options.cfg.system.caddy.enable = mkEnableOption "caddy";
  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = ["github.com/caddy-dns/cloudflare@v0.2.4"];
        hash = "sha256-hEHgAG0F0ozHRAPuxEqLyTATBrE+pajeXDiSNwniorg=";
      };
      environmentFile = config.sops.secrets."cloudflare".path;
      virtualHosts."*.arieimer.net" = {
        extraConfig = ''
          tls {
            dns cloudflare {env.CLOUDFLARE_API_TOKEN}
          }

          @jellyfin host jellyfin.arieimer.net
          handle @jellyfin {
            reverse_proxy localhost:8096
          }
          @immich host immich.arieimer.net
          handle @immich {
            reverse_proxy localhost:2283
          }
          handle {
            respond "Not found" 404
          }
        '';
      };
    };
    sops.secrets."cloudflare".owner = config.services.caddy.user;
  };
}
