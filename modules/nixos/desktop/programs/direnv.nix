{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.direnv;
in {
  options.cfg.programs.direnv.enable = mkEnableOption "direnv";
  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
    hj.packages = [pkgs.devenv];
  };
}
