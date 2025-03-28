{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.cfg.shell.mixed.wleave.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.shell.mixed.enable;
    description = "Installs and configures wleave";
  };
  config = lib.mkIf config.cfg.shell.mixed.wleave.enable {
    cfg.shell.power = "${lib.getExe config.programs.wlogout.package}";
    programs.wlogout = {
      enable = true;
      package = pkgs.wleave;
    };
  };
}
