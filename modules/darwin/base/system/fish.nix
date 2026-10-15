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
    environment.systemPackages = [
      pkgs.dua
      pkgs.onefetch
      pkgs.fzf
      pkgs.zoxide
      pkgs.eza
      pkgs.bat
      pkgs.ripgrep
      pkgs.microfetch
      pkgs.yazi
    ];

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting ""

        alias ... "cd ../.."
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

        function nsp
          nix-shell -p $argv --command "fish"
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

    users.users.${config.cfg.user.username}.shell = pkgs.fish;
  };
}
