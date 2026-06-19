{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.openssh.enable = mkEnableOption "openssh";
  config = mkIf config.cfg.system.openssh.enable {
    services.openssh = {
      enable = true;
    };
  };
}
