{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.anki;
in {
  options.cfg.programs.anki.enable = mkEnableOption "anki";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".local/share/Anki2"];
    hj = {
      packages = [
        pkgs.anki
      ];
      # Beyond hacky fix for AJT mecab controller
      xdg.data.files."Anki2/addons21/200813220/mecab_controller/support/mecab.lin" = {
        type = "copy";
        permissions = "755";
        source = "${pkgs.mecab}/bin/mecab";
      };
    };
  };
}
