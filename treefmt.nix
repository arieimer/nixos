{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    statix.enable = true;
    shfmt.enable = true;
    deadnix.enable = true;
  };
  settings.formatter = {
    deadnix.priority = 1;
    statix.priority = 2;
    nixfmt.priority = 3;
  };
}
