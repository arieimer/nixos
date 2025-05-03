{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.cfg.fish.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables fish shell";
  };
  config = lib.mkIf config.cfg.fish.enable {
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;
  };
}
