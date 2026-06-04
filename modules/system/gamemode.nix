{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.gamemode.enable = mkEnableOption "gamemode";
  config = mkIf config.cfg.system.gamemode.enable {
    programs.gamemode.enable = true;
  };
}
