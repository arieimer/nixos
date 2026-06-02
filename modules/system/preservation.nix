{
  config,
  inputs,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  imports = [
    inputs.preservation.nixosModules.default
    inputs.disko.nixosModules.disko
  ];
  options.cfg.preservation.directories = mkOption {
    type = types.listOf types.str;
    default = [ ];
  };
  options.cfg.preservation.files = mkOption {
    type = types.listOf types.str;
    default = [ ];
  };
  options.cfg.disko.tmpfsSize = mkOption {
    type = types.ints.between 1 100;
    default = 25;
  };
  options.cfg.disko.disk = mkOption {
    type = types.str;
    default = "/dev/vda";
  };
  options.cfg.disko.swapSize = mkOption {
    type = types.strMatching "[0-9]+(M|G|T)";
    default = "4G";
  };
  config = {
    preservation = {
      enable = true;
      preserveAt."/persistent" = {
        files = [
          { file = "/etc/machine-id"; inInitrd = true; }
        ];
        directories = [
          "/var/lib/systemd/timers"
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
          "/var/log"
          {
            directory = "/etc/sops/age";
            inInitrd = true;
          }
          "/var/db/sudo"
          "/etc/NetworkManager/system-connections"
          "/var/lib/bluetooth"
        ];
        users.${config.cfg.user.username} = {          
        directories = [
          ".config/nixos"
        ] ++ config.cfg.preservation.directories;
        files = config.cfg.preservation.files;
        };
      };
    };
    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persistent".neededForBoot = true;
    disko.devices.nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=${toString config.cfg.disko.tmpfsSize}%"
          "mode=755"
        ];
      };
    };
    disko.devices.disk.main = {
      device = config.cfg.disko.disk;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            name = "ESP";
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          swap = {
            name = "swap";
            size = config.cfg.disko.swapSize;
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = {
                "/persistent" = {
                  mountOptions = ["subvol=persistent" "noatime"];
                  mountpoint = "/persistent";
                };
                "/nix" = {
                  mountOptions = ["subvol=nix" "noatime" "compress=zstd:1"];
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
      };
    };
  };
}
