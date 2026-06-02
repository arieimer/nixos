{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf optionalString;
in
{
  options.cfg.system.fish.enable = mkEnableOption "fish";
  config = mkIf config.cfg.system.fish.enable {
    users.defaultUserShell = pkgs.fish;
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting ""
        alias ... "cd ../.."
        function nsp
          nix-shell -p $argv --command "fish"
        end
        cd ~
      '' + optionalString config.cfg.programs.yazi.enable ''
        function y
          set tmp (mktemp -t "yazi-cwd.XXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        end
      '';
    };
  };
}
