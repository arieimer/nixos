{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.immich;
in {
  options.cfg.programs.immich.enable = mkEnableOption "immich";
  config = mkIf cfg.enable {
    services.immich = {
      enable = true;
    };
  };
}
