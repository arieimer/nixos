{
  system.stateVersion = "26.11";
  cfg = {
    system = {
      kernel = "latest";
      # kernel = "cachyos-v3";
      nvidia.enable = true;
      greetd.enable = false;
      ly.enable = true;
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
      ghostty.enable = true;
      mullvad.enable = true;
      loupe.enable = true;
      noctalia.enable = true;
      steam.enable = true;
      qbittorrent.enable = true;
      prismlauncher.enable = true;
      heroic.enable = true;
      nixcord.enable = true;
      zen.enable = true;
      nvf.enable = true;
      fcitx5.enable = true;
      thunar.enable = true;
      git.enable = true;
      yazi.enable = true;
      btop.enable = true;
      fastfetch.enable = true;
      niri = {
        enable = true;
        monitors = [
          "DP-1, 1920x1080@240, 1, x=0 y=0"
          "HDMI-A-1, 1920x1080@75, 1, x=-1920 y=0"
        ];
      };
    };
    user = {
      username = "ari";
      email = "ari.eimer@proton.me";
    };
    disko = {
      disk = "/dev/disk/by-id/nvme-WD_Blue_SN570_500GB_222622801561";
      swapSize = "20G";
    };
  };
}
