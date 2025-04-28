{
  lib,
  config,
  ...
}:
{
  options.cfg.boot.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Sets up Systemd boot";
  };
  config = lib.mkIf config.cfg.boot.enable {
    boot = {
      initrd.systemd.enable = true;
      loader = {
        timeout = 0;
        systemd-boot = {
          enable = true;
          configurationLimit = 20;
          editor = false;
        };
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
