{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkOption types mkIf;
  cfg = config.cfg.disko;
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];
  options.cfg.disko = {
    tmpfsSize = mkOption {
      type = types.ints.between 1 100;
      default = 25;
    };
    disk = mkOption {
      type = types.str;
      default = "/dev/vda";
    };
    swapSize = mkOption {
      type = types.strMatching "[0-9]+(M|G|T)";
      default = "4G";
    };
  };
  config = {
    disko.devices = {
      nodev."/" = mkIf config.cfg.preservation.enable {
        fsType = "tmpfs";
        mountOptions = [
          "size=${toString cfg.tmpfsSize}%"
          "mode=755"
        ];
      };
      disk.main = {
        device = cfg.disk;
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
              size = cfg.swapSize;
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
                  "/persistent" = mkIf config.cfg.preservation.enable {
                    mountOptions = ["subvol=persistent" "noatime"];
                    mountpoint = "/persistent";
                  };
                  "/root" = mkIf (!config.cfg.preservation.enable) {
                    mountpoint = "/";
                    mountOptions = ["noatime" "compress=zstd:1"];
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
  };
}
