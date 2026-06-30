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
    };
    programs = {
      jellyfin.enable = true;
    };
    user = {
      username = "ari";
      authorizedKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEf1YkWtfe11NHCJ+vBikiQH/LZWT7n5vQcOoXIeHXNa ari.eimer@proton.me"];
    };
    disko = {
      disk = "/dev/disk/by-id/ata-256GB_SSD_CM53CBH2606858";
      swapSize = "10G";
    };
  };
}
