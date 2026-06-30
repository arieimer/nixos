{
  hostName,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.syncthing;
  obsidianPath = {
    kaishi = "~/Documents/again";
    katei = "~/Syncthing/again";
  };
in {
  options.cfg.programs.syncthing.enable = mkEnableOption "syncthing";
  config = mkIf cfg.enable {
    cfg.preservation.directories = [
      {
        directory = "/var/lib/syncthing";
        user = config.services.syncthing.user;
        group = config.services.syncthing.group;
        mode = "0700";
      }
    ];
    cfg.preservation.homeDirectories = mkIf (hostName
      != "kaishi") [
      "Syncthing"
    ];
    # syncthing generate --home=syncthing-init/host-x
    sops.secrets."syncthing/${hostName}/cert" = {
      owner = config.services.syncthing.user;
      group = config.services.syncthing.group;
    };
    sops.secrets."syncthing/${hostName}/key" = {
      owner = config.services.syncthing.user;
      group = config.services.syncthing.group;
    };
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      dataDir = "/home/${config.cfg.user.username}";
      user = config.cfg.user.username;
      group = "users";
      cert = config.sops.secrets."syncthing/${hostName}/cert".path;
      key = config.sops.secrets."syncthing/${hostName}/key".path;
      settings = {
        devices = {
          "kaishi".id = "ASF3RG4-OM5YAZS-TWUBADG-FDOAUJD-3QV5YYX-EL5XGQT-UXAW6TJ-6KFKLQB";
          "katei".id = "SNCB7VL-7WNJBWL-ZTPEKVX-7YPQ5OP-2WDQCFM-MUTKCPN-JELI3EB-ZYCKCAT";
        };
        folders = {
          "obsidian" = {
            id = "obsidian";
            label = "Obsidian";
            path = obsidianPath.${hostName};
            devices = ["kaishi" "katei"];
          };
        };
      };
    };
    systemd.services.syncthing-init = {
      wantedBy = lib.mkForce ["default.target"];
      after = lib.mkForce ["syncthing.service" "default.target"];
    };
  };
}
