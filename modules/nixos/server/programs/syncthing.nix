{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.syncthing.enable = mkEnableOption "syncthing";
  config = mkIf config.cfg.programs.syncthing.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      group = "users";
      user = config.cfg.user.username;
    };
  };
}
