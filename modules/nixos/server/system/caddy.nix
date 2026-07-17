{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf mapAttrsToList concatStringsSep types;
  cfg = config.cfg.system.caddy;

  mkVhost = name: proxyCfg: ''
    @${name} host ${name}.arieimer.net
    handle @${name} {
      reverse_proxy localhost:${toString proxyCfg.port}
    }
  '';
in {
  options.cfg.system.caddy = {
    enable = mkEnableOption "caddy";

    proxies = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          port = mkOption {
            type = types.port;
          };
        };
      });
      default = {};
    };
  };

  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = ["github.com/caddy-dns/cloudflare@v0.2.4"];
        hash = "sha256-hEHgAG0F0ozHRAPuxEqLyTATBrE+pajeXDiSNwniorg=";
      };
      environmentFile = config.sops.secrets."cloudflare".path;
      virtualHosts."*.arieimer.net".extraConfig = ''
        tls {
          dns cloudflare {env.CLOUDFLARE_API_TOKEN}
        }

        ${concatStringsSep "\n" (mapAttrsToList mkVhost cfg.proxies)}

        handle {
          respond "Not found" 404
        }
      '';
    };
    sops.secrets."cloudflare".owner = config.services.caddy.user;
  };
}
