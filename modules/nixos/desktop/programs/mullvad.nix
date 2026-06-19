{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  mullvadType =
    if config.cfg.programs.mullvad.enableGUI
    then pkgs.mullvad-vpn
    else pkgs.mullvad;
in {
  options.cfg.programs.mullvad = {
    enable = mkEnableOption "mullvad-vpn";
    enableGUI = mkEnableOption "mullvad-vpn GUI";
  };
  config = mkIf config.cfg.programs.mullvad.enable {
    cfg.preservation.directories = ["/etc/mullvad-vpn"];
    services.mullvad-vpn = {
      enable = true;
      package = mullvadType;
    };
  };
}
