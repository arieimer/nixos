{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.tmux;
in {
  options.cfg.programs.tmux.enable = mkEnableOption "tmux";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      extraConfig = ''
        unbind C-b
        set -g prefix C-a
      '';
    };
  };
}
