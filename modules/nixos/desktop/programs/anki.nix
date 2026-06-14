{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  addonPath = pkg: "${pkg}/share/anki/addons/${lib.removePrefix "anki-addon-" pkg.pname}";
in {
  options.cfg.programs.anki.enable = mkEnableOption "anki";
  config = mkIf config.cfg.programs.anki.enable {
    cfg.preservation.homeDirectories = [".local/share/Anki2"];
    hj = {
      packages = [
        pkgs.anki
      ];
      xdg.data.files = {
        "Anki2/addons21/anki-connect".source = addonPath pkgs.ankiAddons.anki-connect;
        "Anki2/addons21/review-heatmap".source = addonPath pkgs.ankiAddons.review-heatmap;
        "Anki2/addons21/passfail2".source = addonPath pkgs.ankiAddons.passfail2;
        # Rest must be state for now...
      };
    };
  };
}
