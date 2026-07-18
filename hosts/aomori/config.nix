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
      podman.enable = true;
      caddy.enable = true;
      amd.enable = true;
    };
    programs = {
      # syncthing.enable = true;
      # immich.enable = true;
      # jellyfin.enable = true;
      minecraft.enable = true;
      radicale.enable = true;
      # paperless.enable = true;
      atuin.enable = true;
      gatus.enable = true;
      adguardhome.enable = true;
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
