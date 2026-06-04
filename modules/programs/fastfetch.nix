{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.fastfetch.enable = mkEnableOption "fastfetch";
  config = mkIf config.cfg.programs.fastfetch.enable {
    hj = {
      packages = [
        pkgs.fastfetch
      ];
      xdg.config.files."fastfetch/config.jsonc" = {
        generator = lib.toJSON;
        value = {
          display = {
            separator = " ➜ ";
            color = "white";
          };

          modules = [
            {
              type = "custom";
              format = "┌──────────── Hardware Information ────────────┐";
            }
            {
              type = "cpu";
              key = " CPU";
              keyColor = "blue";
            }
            {
              type = "board";
              key = " Board";
              keyColor = "magenta";
            }
            {
              type = "gpu";
              format = "{2} {3}";
              key = "󰛇 GPU";
              keyColor = "yellow";
            }
            {
              type = "memory";
              key = " Memory";
              keyColor = "green";
            }
            {
              type = "display";
              key = "󰍹 Display";
              keyColor = "cyan";
              compactType = "original";
            }
            "break"
            {
              type = "custom";
              format = "├──────────── Software Information ────────────┤";
            }
            {
              type = "os";
              key = " OS";
              keyColor = "blue";
            }
            {
              type = "kernel";
              key = " Kernel";
              keyColor = "red";
            }
            {
              type = "shell";
              key = " Shell";
              keyColor = "magenta";
            }
            {
              type = "wm";
              key = " WM";
              keyColor = "cyan";
            }
            {
              type = "terminal";
              key = " Terminal";
              keyColor = "yellow";
            }
            {
              type = "packages";
              key = "󰏖 Packages";
              keyColor = "green";
            }
            {
              type = "uptime";
              key = "󱫐 Uptime";
              keyColor = "white";
            }
            {
              type = "custom";
              format = "└──────────────────────────────────────────────┘";
            }
            "break"
            {
              type = "colors";
              symbol = "block";
              paddingLeft = 12;
            }
          ];
        };
      };
    };
  };
}
