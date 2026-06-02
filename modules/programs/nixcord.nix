{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [
    inputs.nixcord.nixosModules.nixcord
  ];
  options.cfg.programs.nixcord.enable = mkEnableOption "nixcord";
  config = mkIf config.cfg.programs.nixcord.enable {
    cfg.preservation.directories = [ ".config/vesktop" ];
    programs.nixcord = {
      discord.enable = false;
      enable = true;
      user = config.cfg.user.username;
      vesktop = {
        enable = true;
        autoscroll.enable = true;
      };
    };
  };
}
