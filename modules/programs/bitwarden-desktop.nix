{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.bitwarden.enable = mkEnableOption "bitwarden-desktop client";
  config = mkIf config.cfg.programs.bitwarden.enable {
    hj.packages = [pkgs.bitwarden-desktop]; # broken until nixpkgs#526914
  };
}
