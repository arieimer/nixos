{
  config,
  pkgs,
  lib,
  ...  
}:
{
  config = {
    home.packages = with pkgs; [
      (lib.mkIf config.cfg.shell.mixed.enable
        (pkgs.writeShellApplication {
          name = "mixed.audio.sh";
          runtimeInputs = [ ];
          text = builtins.readFile ./mixed.audio.sh;
        }))
    ];
  };
}
