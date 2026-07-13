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
    sops.secrets."CF_API_KEY" = {};
    virtualisation.oci-containers.containers.gtnh = mkIf false {
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
        "/home/${config.cfg.user.username}/Minecraft/gtnh:/data"
      ];
    };
    virtualisation.oci-containers.containers.starT = mkIf false {
      image = "itzg/minecraft-server:java17";
      extraOptions = ["--network=host"];
      environmentFiles = [config.sops.secrets."CF_API_KEY".path];
      environment = {
        EULA = "true";
        TYPE = "AUTO_CURSEFORGE";
        MEMORY = "8G";
        LEVEL_TYPE = "skyblockbuilder:skyblock";
        DIFFICULTY = "0";
        CF_SLUG = "star-technology";
        WHITELIST = "7939";
        OPS = "7939";
        DUMP_SERVER_PROPERTIES = "TRUE";
        CREATE_CONSOLE_IN_PIPE = "true";
      };
      volumes = [
        "/home/${config.cfg.user.username}/Minecraft/starT:/data"
      ];
    };
    virtualisation.oci-containers.containers.nomi-ceu = mkIf true {
      image = "itzg/minecraft-server:java8";
      extraOptions = ["--network=host"];
      environmentFiles = [config.sops.secrets."CF_API_KEY".path];
      environment = {
        EULA = "true";
        TYPE = "AUTO_CURSEFORGE";
        MEMORY = "8G";
        LEVEL_TYPE = "lostcities";
        DIFFICULTY = "0";
        CF_SLUG = "nomi-ceu";
        WHITELIST = "7939";
        OPS = "7939";
        DUMP_SERVER_PROPERTIES = "TRUE";
        CREATE_CONSOLE_IN_PIPE = "true";
        CURSEFORGE_FILES = "https://www.curseforge.com/minecraft/mc-mods/ae2-fluid-crafting-rework,https://www.curseforge.com/minecraft/mc-mods/flux-networks,https://www.curseforge.com/minecraft/mc-mods/lazy-ae2,https://www.curseforge.com/minecraft/mc-mods/zbgt,https://www.curseforge.com/minecraft/mc-mods/libnine";
      };
      volumes = [
        "/home/${config.cfg.user.username}/Minecraft/nomi-ceu:/data"
      ];
    };
    cfg.preservation.homeDirectories = [
      "Minecraft/gtnh"
      "Minecraft/starT"
      "Minecraft/nomi-ceu"
    ];
  };
}
