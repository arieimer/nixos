{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.cfg.mullvad.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures mullvad-vpn";
  };
  config = lib.mkIf config.cfg.mullvad.enable {
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };
}
