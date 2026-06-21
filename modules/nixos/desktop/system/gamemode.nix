{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.gamemode;
in {
  options.cfg.system.gamemode.enable = mkEnableOption "gamemode";
  config = mkIf cfg.enable {
    programs.gamemode.enable = true;
    cfg.user.extraGroups = ["gamemode"];
  };
}
