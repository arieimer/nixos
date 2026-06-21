{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.nixcord;
in {
  imports = [
    inputs.nixcord.nixosModules.nixcord
  ];
  options.cfg.programs.nixcord.enable = mkEnableOption "nixcord";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".config/vesktop"];
    programs.nixcord = {
      discord.enable = false;
      enable = true;
      user = config.cfg.user.username;
      vesktop = {
        enable = true;
        autoscroll.enable = true;
      };
      config = {
        useQuickCss = true;
        enabledThemes = ["noctalia.theme.css"];
        plugins = {
          alwaysTrust.enable = true;
          fakeNitro.enable = true;
          gameActivityToggle.enable = true;
          messageLatency.enable = true;
          messageLogger.enable = true;
          noF1.enable = true;
          typingIndicator.enable = true;
          youtubeAdblock.enable = true;
          mentionAvatars.enable = true;
          volumeBooster.enable = true;
        };
      };
      quickCss = ''
        body {
                --custom-dms-icon: hide;
        }
        /* Hides Store and Shop button */
        [href="/store"],
        [href='/shop'] {
                display: none;
        }
        /* Hide Nitro Gift button */
        button[aria-label="Send a gift"] {
                display: none;
        }
        /* Hide GIF picker button */
        div[aria-label="Open GIF picker"] {
            display: none !important;
        }

        /* Hide sticker picker button */
        div[aria-label="Open sticker picker"] {
            display: none;
        }

        /* Remove annoying gaps between buttons (vc, text inputs, etc) */
        div[class*="buttons_"] {
            gap: 0 !important;
        }

        /* Hide app launcher */
        .app-launcher-entrypoint{
            display: none !important;
        }
      '';
    };
  };
}
