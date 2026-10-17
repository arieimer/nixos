{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.zathura;
in {
  options.cfg.programs.zathura.enable = mkEnableOption "zathura";
  config = mkIf cfg.enable {
    hj = {
      packages = [pkgs.zathura];
      xdg.config.files."zathura/zathurarc".text = ''
        include noctaliarc
        set recolor true
      '';
    };
    xdg.mime.defaultApplications."application/pdf" = "org.pwmt.zathura.desktop";
  };
}
