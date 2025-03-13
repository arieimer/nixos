{
  lib,
  config,
  username,
  ...
}:
{
  options.cfg.gaming.gamemode.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.gaming.enable;
    description = "Enables gamemode";
  };
  config = lib.mkIf config.cfg.gaming.gamemode.enable {
    programs.gamemode.enable = true;
    users.users.${username}.extraGroups = [ "gamemode" ];
  };
}
