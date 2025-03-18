{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.cfg.hypr.hyprcursor.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables hyprcursor configuration because stylix doesnt do it";
  };
  config = lib.mkIf config.cfg.hypr.hyprcursor.enable {
    home.pointerCursor = {
      gtk.enable = true;
      hyprcursor.enable = true;
      name = lib.mkForce "Bibata-Modern-Ice";
      package = lib.mkForce pkgs.bibata-cursors;
    };
  };
}
