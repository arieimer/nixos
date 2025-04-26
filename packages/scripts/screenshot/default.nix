{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.cfg.hypr.screenshot.enable {
    home.packages = with pkgs; [
      (pkgs.writeShellApplication {
        name = "screenshot.sh";
        runtimeInputs = [
          pkgs.grim
          pkgs.slurp
          pkgs.libnotify
          pkgs.wl-clipboard
        ];
        text = builtins.readFile ./screenshot.sh;
      })
    ];
  };
}
