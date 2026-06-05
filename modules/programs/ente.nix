{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.ente.enable = mkEnableOption "ente";
  config = mkIf config.cfg.programs.ente.enable {
    hj.packages = [pkgs.ente-auth];
  };
}
