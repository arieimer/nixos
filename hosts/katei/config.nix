{self, ...}: {
  system.stateVersion = "26.11";
  imports = [
    self.nixosModules.base
    self.nixosModules.server
  ];
  cfg = {
    system = {
      fish.enable = true;
      tailscale.enable = true;
      caddy.enable = true;
    };
    programs = {
      jellyfin.enable = true;
      syncthing.enable = true;
    };
    user = {
      username = "ari";
    };
    disko = {
      disk = "/dev/disk/by-id/ata-256GB_SSD_CM53CBH2606858";
      swapSize = "10G";
    };
  };
}
