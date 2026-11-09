{self, ...}: {
  system.stateVersion = 6;
  imports = [self.darwinModules.base];
  cfg = {
    system = {
      nix.hostName = "saitama";
      fish.enable = true;
    };
    programs = {
      btop.enable = true;
      direnv.enable = true;
      ghostty.enable = true;
      lazygit.enable = true;
      nvf = {
        enable = true;
        notesDir = "/Users/ari/Documents/notes";
      };
      tmux.enable = true;
      yazi.enable = true;
    };
    user.username = "ari";
  };
}
