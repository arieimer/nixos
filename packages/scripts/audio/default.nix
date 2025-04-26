{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      (lib.mkIf config.cfg.shell.mixed.enable (
        pkgs.writeShellApplication {
          name = "mixed.audio.sh";
          runtimeInputs = [ pkgs.libnotify ];
          text = builtins.readFile ./mixed.audio.sh;
        }
      ))
    ];
  };
}
