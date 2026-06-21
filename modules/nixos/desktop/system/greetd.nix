{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.system.greetd;
in {
  options.cfg.system.greetd.enable = mkEnableOption "greetd";
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];
  config = mkIf cfg.enable {
    cfg.preservation.directories = ["/var/lib/noctalia-greeter"];
    programs.noctalia-greeter = {
      enable = true;
      greeter-args = "--user ${config.cfg.user.username}";
      settings = {
        cursor = mkIf config.cfg.system.cursor.enable {
          package = pkgs.bibata-cursors;
          theme = "Bibata-Modern-Ice";
          size = 24;
        };
      };
    };
  };
}
