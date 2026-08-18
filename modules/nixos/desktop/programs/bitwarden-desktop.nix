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
    cfg.preservation.homeDirectories = [".config/Bitwarden"];
    hj.packages = [pkgs.bitwarden-desktop];
  };
}
