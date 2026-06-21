{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.cfg.preservation;
in {
  imports = [
    inputs.preservation.nixosModules.default
  ];
  options.cfg.preservation = {
    directories = mkOption {
      type = types.listOf types.str;
      default = [];
    };
    homeDirectories = mkOption {
      type = types.listOf types.str;
      default = [];
    };
    files = mkOption {
      type = types.listOf types.str;
      default = [];
    };
    homeFiles = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };
  config = {
    preservation = {
      enable = true;
      preserveAt."/persistent" = {
        files =
          [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ]
          ++ cfg.files;
        directories =
          [
            "/var/log"
            "/var/db/sudo"
            "/var/lib/systemd/timers"
            "/var/lib/bluetooth"
            "/etc/NetworkManager/system-connections"
            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }
            {
              directory = "/etc/sops/age";
              inInitrd = true;
            }
          ]
          ++ cfg.directories;
        users.${config.cfg.user.username} = {
          directories =
            [
              ".config/nixos"
            ]
            ++ cfg.homeDirectories;
          files =
            [
              ".ssh/known_hosts"
            ]
            ++ cfg.homeFiles;
        };
      };
    };
    systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];
    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persistent".neededForBoot = true;
  };
}
