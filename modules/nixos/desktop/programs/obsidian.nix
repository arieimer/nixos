{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.obsidian;
in {
  options.cfg.programs.obsidian.enable = mkEnableOption "obsidian";
  config = mkIf cfg.enable {
    hj = {
      packages = [pkgs.obsidian];
      xdg.config.files."obsidian/obsidian.json" = {
        generator = lib.toJSON;
        value.vaults."again" = {
          path = "/home/${config.cfg.user.username}/Documents/again";
          open = true;
        };
      };
    };
  };
}
