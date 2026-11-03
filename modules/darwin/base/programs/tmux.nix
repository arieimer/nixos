{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.tmux;
in {
  options.cfg.programs.tmux.enable = mkEnableOption "tmux";

  config = mkIf cfg.enable {
    hj = {
      packages = [pkgs.tmux];
      xdg.config.files."tmux/tmux.conf".text = ''
        set -g history-limit 10000
        set -g renumber-windows on
        unbind C-b
        set -g prefix C-a
        setw -g mode-keys vi
        bind s split-window -h
        bind v split-window -v
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        bind < resize-pane -L 10
        bind > resize-pane -R 10
        bind - resize-pane -D 10
        bind + resize-pane -U 10
      '';
    };
  };
}
