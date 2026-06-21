{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.bitwarden;
in {
  options.cfg.programs.bitwarden.enable = mkEnableOption "bitwarden-desktop client";
  config = mkIf cfg.enable {
    hj.packages = [pkgs.bitwarden-desktop]; # broken until nixpkgs#526914
    # TODO: when not broken add to niri screen blocker
  };
}
