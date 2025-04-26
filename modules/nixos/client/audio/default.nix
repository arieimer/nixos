{
  config,
  lib,
  ...
}:
{
  options.cfg.audio.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enables audio via pipewire";
  };
  imports = [ ./rnnoise.nix ];

  config = lib.mkIf config.cfg.audio.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true; # Is this needed?
    };
    security.rtkit.enable = true;
  };
}
