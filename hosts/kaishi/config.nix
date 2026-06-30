{self, ...}: {
  system.stateVersion = "26.11";
  imports = [
    self.nixosModules.base
    self.nixosModules.desktop
  ];
  cfg = {
    system = {
      kernel = {
        type = "cachyos-v3";
        scx.enable = true;
      };
      nvidia.enable = true;
      greetd.enable = true;
      networkmanager.enable = true;
      fish.enable = true;
      tailscale.enable = true;
      fonts.enable = true;
      gamemode.enable = true;
      pipewire.enable = true;
      xdg.enable = true;
      cursor.enable = true;
      qt.enable = true;
      bluetooth.enable = true;
      udiskie.enable = true;
      gtk.enable = true;
    };
    programs = {
      ghostty.enable = true;
      syncthing.enable = true;
      ente.enable = true;
      # atuin.enable = true;
      obsidian.enable = true;
      direnv.enable = true;
      # bitwarden.enable = true; # broken build is a broken build
      mullvad = {
        enable = true;
        enableGUI = true;
      };
      mpv.enable = true;
      obs.enable = true;
      anki.enable = true;
      jellyfin-tui.enable = true;
      lazygit.enable = true;
      loupe.enable = true;
      decibels.enable = true;
      noctalia.enable = true;
      steam.enable = true;
      qbittorrent.enable = true;
      prismlauncher.enable = true;
      heroic.enable = true;
      nixcord.enable = true;
      zen.enable = true;
      nvf.enable = true;
      fcitx5.enable = true;
      nautilus.enable = true;
      git.enable = true;
      yazi.enable = true;
      btop.enable = true;
      niri = {
        enable = true;
        monitors = {
          "DP-1" = {
            mode = "1920x1080@239.964";
            scale = 1;
            position = "x=0 y=0";
            focusAtStartup = true;
          };
          "HDMI-A-1" = {
            mode = "1920x1080@74.973";
            scale = 1;
            position = "x=-1920 y=0";
          };
        };
      };
    };
    user = {
      username = "ari";
      email = "ari.eimer@proton.me";
    };
    disko = {
      disk = "/dev/disk/by-id/nvme-ADATA_SX8200PNP_2O042924KCY";
      swapSize = "20G";
    };
  };
}
