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
    cfg.preservation.homeDirectories = [".local/share/io.ente.auth"];
    hj.packages = [pkgs.ente-auth];
  };
}
