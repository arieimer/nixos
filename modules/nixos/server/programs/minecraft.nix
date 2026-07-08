{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.minecraft;
in {
  options.cfg.programs.minecraft.enable = mkEnableOption "minecraft";
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers.gtnh = mkIf true {
      image = "itzg/minecraft-server:java25";
      extraOptions = ["--network=host" "--tty" "--interactive"];
      environment = {
        EULA = "true";
        TYPE = "GTNH";
        GTNH_PACK_VERSION = "2.8.4";
        MEMORY = "8G";
        WHITELIST = "7939";
        OPS = "7939";
        DUMP_SERVER_PROPERTIES = "TRUE";
        CREATE_CONSOLE_IN_PIPE = "true";
      };
      volumes = [
        "/home/${config.cfg.user.username}/Minecraft:/data"
      ];
      autoStart = true;
    };
    cfg.preservation.homeDirectories = ["Minecraft"];
  };
}
