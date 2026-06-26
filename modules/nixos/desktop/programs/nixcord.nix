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
          plainFolderIcon.enable = true;
          memberCount.enable = true;
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
                --custom-dms-icon: off;
        }
        [href="/store"],
        [href="/quest-home"],
        [href='/shop'],
        div[aria-label="Open sticker picker"],
        div[aria-label="Apps"],
        div[aria-label="Open GIF picker"],
        div[aria-label="Send a gift"] {
                display: none;
        }
      '';
    };
  };
}
