{
  lib,
  config,
  ...
}:
{
  options.cfg.gui.foot.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures foot (terminal emulator)";
  };
  config = lib.mkIf config.cfg.gui.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        cursor = {
          style = "beam";
          blink = "yes";
        };
      };
    };
  };
}
