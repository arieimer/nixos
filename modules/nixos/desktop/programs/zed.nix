{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.zed.enable = mkEnableOption "zed";
  config = mkIf config.cfg.programs.zed.enable {
    # cfg.preservation.homeDirectories = [".local/share/io.ente.auth"];
    hj.packages = [pkgs.zed-editor];
  };
}
