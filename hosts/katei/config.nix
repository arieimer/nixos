{self, ...}: {
  system.stateVersion = "26.11";
  imports = [
    self.nixosModules.base
    self.nixosModules.desktop
  ];
  cfg = {
    system = {
      # kernel = "latest";
      kernel = "cachyos-v3";
      nvidia.enable = true;
      greetd.enable = true;
      scx.enable = true;
      networkmanager.enable = true;
      fish.enable = true;
      fonts.enable = true;
      gamemode.enable = true;
      pipewire.enable = true;
      xdg.enable = true;
      cursor.enable = true;
      qt.enable = true;
      gtk.enable = true;
      sops.enable = true;
    };
    programs = {
    };
    user = {
      username = "ari";
      email = "ari.eimer@proton.me";
    };
    disko = {
      # disk = "/dev/disk/by-id/nvme-ADATA_SX8200PNP_2O042924KCY";
      swapSize = "10G";
    };
  };
}
