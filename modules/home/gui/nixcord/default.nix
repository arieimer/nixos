{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  options.cfg.gui.nixcord.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Discord with vesktop for nix";
  };
  imports = [
    inputs.nixcord.homeModules.nixcord
    inputs.chaotic.homeManagerModules.default
  ];
  config = lib.mkIf config.cfg.gui.nixcord.enable {
    stylix.targets.vesktop.enable = false; # Possibly unneccessary
    stylix.targets.vencord.enable = false; # same here ^^
    programs.nixcord = {
      enable = true;
      discord = {
        package = pkgs.discord-krisp;
        # ^^ Requires the nixosmodule to be loaded which is done in the kernel config file.
        autoscroll.enable = true;
      };
      config = {
        useQuickCss = true;
        plugins = {
          callTimer.enable = true;
          fakeNitro.enable = true;
          fixSpotifyEmbeds.enable = true;
          gameActivityToggle.enable = true;
          mentionAvatars.enable = true;
          messageLatency.enable = true;
          messageLogger.enable = true;
          noF1.enable = true;
          noOnboardingDelay.enable = true;
          plainFolderIcon.enable = true;
          typingIndicator.enable = true;
          volumeBooster.enable = true;
          youtubeAdblock.enable = true;
          webScreenShareFixes.enable = true;
        };
      };
      quickCss = ''
        /* Hides Store and Shop button */
        [href="/store"], 
        [href='/shop']
        {
          display: none;
        }
        /* Hide Nitro Gift button */
        button[aria-label="Send a gift"] {
          display: none;
        }
        /* Hide GIF picker button */
        button[aria-label="Open GIF picker"] {
          display: none;
        }
        /* Hide sticker picker button */
        button[aria-label="Open sticker picker"] {
          display: none;
        }
        /* Hide app launcher */
        [class*=channelAppLauncher_] {
          display: none !important;
        }
      '';
    };
  };
}
