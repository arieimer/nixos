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
    hj = {
      packages = [
        (pkgs.anki.withAddons [
          ((pkgs.callPackage ../../../../pkgs/packages/ajt-japanese.nix {}).withConfig {
            # https://github.com/donkuri/lapis/blob/main/docs/anki_setup.md
            config = {
              profiles = [
                {
                  name = "Furigana";
                  note_type = "Lapis";
                  source = "Sentence";
                  destination = "SentenceFurigana";
                  mode = "furigana";
                  split_morphemes = true;
                  triggered_by = "focus_lost,toolbar_button,note_added";
                  overwrite_destination = false;
                  color_code_pitch = "";
                }
                {
                  name = "Furigana Overwrite";
                  note_type = "Lapis";
                  source = "Sentence";
                  destination = "SentenceFurigana";
                  mode = "furigana";
                  split_morphemes = true;
                  triggered_by = "bulk_add";
                  overwrite_destination = true;
                  color_code_pitch = "";
                }
                {
                  name = "Pitch Accent for Lapis";
                  note_type = "Lapis";
                  source = "ExpressionFurigana";
                  destination = "PitchPosition";
                  mode = "pitch";
                  split_morphemes = false;
                  triggered_by = "focus_lost,toolbar_button,note_added,bulk_add";
                  overwrite_destination = false;
                  output_format = "html_and_number";
                }
              ];
              furigana = {
                skip_numbers = true;
                prefer_literal_pronunciation = false;
                reading_separator = ", ";
                blocklisted_words = "人";
                mecab_only = "彼,猫,首,母,顔,木,頭,私,弟,空,体,行く";
                maximum_results = 1;
                discard_mode = "discard_extra";
              };
              pitch_accent = {
                lookup_shortcut = "Alt+P";
                output_hiragana = false;
                kana_lookups = true;
                skip_numbers = true;
                reading_separator = "・";
                word_separator = "、";
                blocklisted_words = "こと,へ,か,よ,ん,だ,び,の,や,ね,ば,て,と,た,が,に,な,は,も,ます,から,いる,たち,てる,う,ましょ,たい,する,です,ない";
                maximum_results = 3;
                discard_mode = "discard_extra";
                html_style = "javdejong";
              };
            };
          })
          (pkgs.callPackage ../../../../pkgs/packages/kanjigrid.nix {})
          pkgs.ankiAddons.anki-connect
          pkgs.ankiAddons.passfail2
          pkgs.ankiAddons.review-heatmap
        ])
      ];
    };
  };
}
