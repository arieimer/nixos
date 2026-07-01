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
      disk = "/dev/disk/by-id/nvme-WD_Blue_SN570_500GB_222622801561";
      swapSize = "16G";
    };
  };
}
