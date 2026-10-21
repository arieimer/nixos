{self, ...}: {
  system.stateVersion = 6;
  imports = [self.darwinModules.base];
  cfg = {
    system.nix.hostName = "saitama";
    system.fish.enable = true;
    programs.btop.enable = true;
    programs.ghostty.enable = true;
    programs.lazygit.enable = true;
    programs.nvf.enable = true;
    programs.yazi.enable = true;
    user.username = "ari";
  };
}
