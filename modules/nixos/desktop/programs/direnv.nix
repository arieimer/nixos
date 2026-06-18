{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.direnv.enable = mkEnableOption "direnv";
  config = mkIf config.cfg.programs.direnv.enable {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
    hj.packages = [pkgs.devenv];
  };
}
