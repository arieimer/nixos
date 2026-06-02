{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.cfg.system.pipewire.enable = mkEnableOption "pipewire";
  config = mkIf config.cfg.system.pipewire.enable {
    cfg.preservation.directories = [ ".local/state/wireplumber" ];
    hj.packages = [
      pkgs.pwvucontrol
    ];
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      extraConfig.pipewire."pipewire"."context.properties"."default.clock.min-quantum" = 1024;
    };
    # services.pipewire.extraConfig.pipewire."pipewire"."context.properties"."default.clock.min-quantum" = 1024;
    security.rtkit.enable = true;
  };
}
