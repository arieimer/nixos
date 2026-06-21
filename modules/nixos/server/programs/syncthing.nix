{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.syncthing;
in {
  options.cfg.programs.syncthing.enable = mkEnableOption "syncthing";
  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      group = "users";
      user = config.cfg.user.username;
    };
  };
}
