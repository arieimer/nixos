{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.lazygit;
in {
  options.cfg.programs.lazygit.enable = mkEnableOption "lazygit";
  config = mkIf cfg.enable {
    hj = {
      packages = [
        pkgs.lazygit
      ];
      xdg.config.files."lazygit/config.yml" = {
        generator = lib.generators.toYAML {};
        value = {
          gui.showIcons = true;
          git.pagers = [{pager = "delta --dark --paging=never";}];
          disableStartupPopups = true;
        };
      };
    };
  };
}
