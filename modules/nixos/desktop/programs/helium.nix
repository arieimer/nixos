{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.helium;
in {
  options.cfg.programs.helium.enable = mkEnableOption "helium browser";
  imports = [
    inputs.helium.nixosModules.default
  ];
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".config/net.imput.helium"];
    programs.helium = {
      enable = true;
      flags = [
        "--ozone-platform-hint=wayland"
        # experimental flags
        "--use-gl=egl"
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
      ];
      # https://cloud.google.com/docs/chrome-enterprise/policies/
      policies = {
        "BrowserSignin" = 0;
        "PasswordManagerEnabled" = false;
        "SyncDisabled" = true;
        "SpellcheckEnabled" = true;
        "SpellcheckLanguage" = ["en-US"];
        "RestoreOnStartup" = 1;
        "ForcedLanguages" = ["ja" "en-US" "en"];
        "ExtensionInstallForcelist" = [
          "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
          "nngceckbapebfimnlniiiahkandclblb" # bitwarden
          "hkledmpjpaehamkiehglnbelcpdflcab" # asbplayer
          "ankepacjgoajhjpenegknbefpmfffdic" # hide youtube shorts
          "likgccmbimhjbgkjambclfkhldnlhbnn" # yomitan
          "oejgccbfbmkkpaidnkphaiaecficdnfn" # toggl track
          "khncfooichmfjbepaaaebmommgaepoid" # unhook
          "ammjkodgmmoknidbanneddgankgfejfh" # 7tv
          "cndibmoanboadcifjkjbdpjgfedanolh" # betterCampus
        ];
        "SiteSearchSettings" = [
          {
            name = "ProtonDB";
            shortcut = "#pd";
            url = "https://www.protondb.com/search?q={searchTerms}";
            featured = false;
          }
          {
            name = "NixOS Options";
            shortcut = "#no";
            url = "https://search.nixos.org/options?query={searchTerms}";
            featured = false;
          }
          {
            name = "Nix Packages";
            shortcut = "#np";
            url = "https://search.nixos.org/packages?query={searchTerms}";
            featured = false;
          }
          {
            name = "Noogle";
            shortcut = "#ng";
            url = "https://noogle.dev/q?term={searchTerms}";
            featured = false;
          }
          {
            name = "Claude";
            shortcut = "#cl";
            url = "https://claude.ai/new?q={searchTerms}";
            featured = false;
          }
          {
            name = "Jisho";
            shortcut = "#ji";
            url = "https://jisho.org/search/{searchTerms}";
            featured = false;
          }
          {
            name = "Nadeshiko";
            shortcut = "#ns";
            url = "https://nadeshiko.co/ja/search/{searchTerms}";
            featured = false;
          }
          {
            name = "Amazon";
            shortcut = "#am";
            url = "https://www.amazon.com/s?k={searchTerms}";
            featured = false;
          }
          {
            name = "SteamDB";
            shortcut = "#sd";
            url = "https://steamdb.info/search/?a=app&q={searchTerms}";
            featured = false;
          }
        ];
      };
    };
  };
}
