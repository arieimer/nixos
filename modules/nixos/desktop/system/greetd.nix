{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.greetd.enable = mkEnableOption "greetd";
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];
  config = mkIf config.cfg.system.greetd.enable {
    cfg.preservation.directories = ["/var/lib/noctalia-greeter"];
    programs.noctalia-greeter = {
      enable = true;
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
