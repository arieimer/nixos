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
    sops.secrets."Minecraft" = {};
    hj.files."Minecraft".type = "directory";
    virtualisation.oci-containers.containers.gtnh = mkIf false {
      image = "itzg/minecraft-server:java25";
      ports = ["25565:25565"];
      environmentFiles = [config.sops.secrets."Minecraft".path];
      environment = {
        TYPE = "GTNH";
        GTNH_PACK_VERSION = "2.8.4";
        MEMORY = "8G";
      };
      volumes = [
        "/home/${config.cfg.user.username}/Minecraft/gtnh:/data"
      ];
    };
    virtualisation.oci-containers.containers.starT = mkIf false {
      image = "itzg/minecraft-server:java17";
      ports = ["25565:25565"];
      environmentFiles = [config.sops.secrets."Minecraft".path];
      environment = {
        TYPE = "AUTO_CURSEFORGE";
        MEMORY = "8G";
        LEVEL_TYPE = "skyblockbuilder:skyblock";
        DIFFICULTY = "0";
        CF_SLUG = "star-technology";
      };
      volumes = [
        "/home/${config.cfg.user.username}/Minecraft/starT:/data"
      ];
    };
    virtualisation.oci-containers.containers.nomi-ceu = mkIf true {
      image = "itzg/minecraft-server:java8";
      ports = ["25565:25565"];
      environmentFiles = [config.sops.secrets."Minecraft".path];
      environment = {
        TYPE = "AUTO_CURSEFORGE";
        MEMORY = "8G";
        LEVEL_TYPE = "lostcities";
        DIFFICULTY = "0";
        CF_SLUG = "nomi-ceu";
        CURSEFORGE_FILES = "https://www.curseforge.com/minecraft/mc-mods/ae2-fluid-crafting-rework,https://www.curseforge.com/minecraft/mc-mods/flux-networks,https://www.curseforge.com/minecraft/mc-mods/lazy-ae2,https://www.curseforge.com/minecraft/mc-mods/zbgt,https://www.curseforge.com/minecraft/mc-mods/libnine";
      };
      volumes = [
        "/home/${config.cfg.user.username}/Minecraft/nomi-ceu:/data"
      ];
    };
  };
}
