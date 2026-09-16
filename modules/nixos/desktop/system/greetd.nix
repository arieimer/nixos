{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.greetd;
in {
  options.cfg.system.greetd.enable = mkEnableOption "greetd";
  config = mkIf cfg.enable {
    cfg.preservation.directories = ["/var/lib/noctalia-greeter"];
    services.displayManager.noctalia-greeter = {
      enable = true;
      extraArgs = ["--user ${config.cfg.user.username}"];
      settings = {
        cursor = mkIf config.cfg.system.cursor.enable {
          package = "${pkgs.bibata-cursors}/share/icons";
          theme = "Bibata-Modern-Ice";
          size = 24;
        };
      };
    };
  };
}
