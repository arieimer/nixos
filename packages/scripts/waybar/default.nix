{
  
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.cfg.shell.mixed.waybar.enable {
    home.packages = with pkgs; [
      (pkgs.writeShellApplication {
        name = "waybar-cpu-temp";
        runtimeInputs = [ pkgs.lm_sensors ];
        text = builtins.readFile ./cpu-temp.sh;
      })
      (pkgs.writeShellApplication {
        name = "waybar-cpu-usage";
        runtimeInputs = [];
        text = builtins.readFile ./cpu-usage.sh;
      })
    ];  
  };  
}
