{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.ente;
in {
  options.cfg.programs.ente.enable = mkEnableOption "ente";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".local/share/io.ente.auth"];
    hj.packages = [pkgs.ente-auth];
  };
}
