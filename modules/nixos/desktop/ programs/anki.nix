{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.anki.enable = mkEnableOption "anki";
  config = mkIf config.cfg.programs.ente.enable {
    cfg.preservation.directories = [".local/share/Anki2"];
    hj.packages = [
      (pkgs.anki.withAddons [
        pkgs.ankiAddons.passfail2
        pkgs.ankiAddons.anki-connect
        pkgs.ankiAddons.review-heatmap
      ])
    ];
  };
}
