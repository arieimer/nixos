{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.zen;
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };
  prefs = {
    # about:config
    "extensions.autoDisableScopes" = 0;
    "extensions.pocket.enabled" = false;
    "middlemouse.paste" = false;
    "general.autoScroll" = true;
    "signon.rememberSignons" = false;
    "zen.welcome-screen.seen" = true;
    "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
  };
  extensions = [
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "sponsorblock" "sponsorBlocker@ajay.app")
    (extension "hide-youtube-shorts" "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}")
    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
    (extension "asbplayer-language-learning" "{e4b27483-2e73-4762-b2ec-8d988a143a40}")
    (extension "yomitan" "{6b733b82-9261-47ee-a595-2dda294a4d08}")
    (extension "toggl-button-time-tracker" "toggl-button@toggl.com")
    (extension "youtube-recommended-videos" "myallychou@gmail.com")
    (extension "7tv-extension" "moz-addon-prod@7tv.app")
  ];
in {
  options.cfg.programs.zen.enable = mkEnableOption "zen browser";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".config/zen" ".cache/zen"];
    hj.packages = [
      (
        pkgs.wrapFirefox
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
        {
          extraPrefs = lib.concatLines (
            lib.mapAttrsToList (
              name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
            )
            prefs
          );
          extraPolicies = {
            DisableTelemetry = true;
            ExtensionSettings = builtins.listToAttrs extensions;
            SearchEngines = {
              Default = "DuckDuckGo";
              Add = [
                {
                  Name = "nixpkgs packages";
                  URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@np";
                }
                {
                  Name = "NixOS options";
                  URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@no";
                }
                {
                  Name = "noogle";
                  URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                  IconURL = "https://noogle.dev/favicon.ico";
                  Alias = "@ng";
                }
              ];
              Remove = [
                "Bing"
                "eBay"
                "Perplexity"
                "Amazon.com"
                "Google"
              ];
            };
          };
        }
      )
    ];
    xdg.mime.defaultApplications = {
      "application/pdf" = "zen.desktop";
      "application/xhtml+xml" = "zen.desktop";
      "text/html" = "zen.desktop";
      "text/xml" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
    };
  };
}
