{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf getExe;
  cfg = config.cfg.system.fish;
in {
  options.cfg.system.fish.enable = mkEnableOption "fish";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".local/share/zoxide"];
    hj.packages = [
      pkgs.dua
      pkgs.onefetch
      pkgs.fzf
      pkgs.zoxide
    ];
    users.defaultUserShell = pkgs.fish;
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting ""
        alias ... "cd ../.."
        function nsp
          nix-shell -p $argv --command "fish"
        end
        alias ls "${getExe pkgs.eza} --color always --icons --group-directories-first"
        alias cat "${getExe pkgs.bat}"
        alias grep "${getExe pkgs.ripgrep}"
        alias fetch "${getExe pkgs.microfetch}"
        function y
          set tmp (mktemp -t "yazi-cwd.XXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        end

        function sudo
          if test "$argv" = !!
            eval command sudo $history[1]
          else
            command sudo $argv
          end
        end
        zoxide init fish --cmd cd | source
      '';
    };
  };
}
