{
  config,
  pkgs,
  lib,
  ...
}: let
  pw_rnnoise_config = {
    "context.modules" = [
      {
        "name" = "libpipewire-module-filter-chain";
        "args" = {
          "node.description" = "Noise Canceling source";
          "media.name" = "Rnnoise-source";
          "filter.graph" = {
            "nodes" = [
              {
                "type" = "ladspa";
                "name" = "rnnoise";
                "plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                "label" = "noise_suppressor_mono";
                "control" = {
                  "VAD Threshold (%)" = config.cfg.audio.rnnoise.vadThreshold;
                  "VAD Grace Period (ms)" = config.cfg.audio.rnnoise.vadGracePeriod;
                  "Retroactive VAD Grace (ms)" = config.cfg.audio.rnnoise.retroactiveVadGrace;
                };
              }
            ];
          };
          "capture.props" = {
            "node.name" = "effect_input.rnnoise";
            "node.passive" = true;
            "audio.channels" = 1;
            "audio.rate" = 48000;
          };
          "playback.props" = {
            "node.name" = "effect_output.rnnoise";
            "media.class" = "Audio/Source";
            "audio.channels" = 1;
            "audio.rate" = 48000;
          };
        };
      }
    ];
  };
in {
  options.cfg.audio.rnnoise.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables the rnnoise pipewire plugin for mic noise suppression.";
  };
  options.cfg.audio.rnnoise.vadThreshold = lib.mkOption {
    type = lib.types.int;
    default = 50;
    description = "Set the rnnoise VAD threshold (%)";
  };
  options.cfg.audio.rnnoise.vadGracePeriod = lib.mkOption {
    type = lib.types.int;
    default = 20;
    description = "Set the rnnoise VAD grace period in milliseconds.";
  };
  options.cfg.audio.rnnoise.retroactiveVadGrace = lib.mkOption {
    type = lib.types.int;
    default = 0;
    description = "Set the rnnoise retroactive VAD grace period in milliseconds.";
  };
  config = {
    services.pipewire = lib.mkIf config.cfg.audio.rnnoise.enable {
      extraConfig.pipewire."99-input-denoising" = pw_rnnoise_config;
    };
  };
}

