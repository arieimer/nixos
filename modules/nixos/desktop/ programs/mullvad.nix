{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
in {
  options.cfg.programs.mullvad.enable = mkEnableOption "mullvad-vpn";
  config = mkIf config.cfg.programs.mullvad.enable {
    # services.resolved.enable = true;
    preservation.preserveAt."/persistent".directories = ["/etc/mullvad-vpn"];
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };
}
