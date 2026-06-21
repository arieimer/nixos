{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.cfg.programs.mullvad;
  mullvadType =
    if cfg.enableGUI
    then pkgs.mullvad-vpn
    else pkgs.mullvad;
in {
  options.cfg.programs.mullvad = {
    enable = mkEnableOption "mullvad-vpn";
    enableGUI = mkEnableOption "mullvad-vpn GUI";
  };
  config = mkIf cfg.enable {
    cfg.preservation.directories = ["/etc/mullvad-vpn"];
    systemd.services.mullvad-daemon.postStart = mkIf config.cfg.system.sops.enable (let
      mullvad = config.services.mullvad-vpn.package;
    in ''
      while ! ${mullvad}/bin/mullvad status >/dev/null; do sleep 1; done
        ${mullvad}/bin/mullvad account login \
        "$(cat ${config.sops.secrets.mullvad.path})"
    '');

    services.mullvad-vpn = {
      enable = true;
      package = mullvadType;
    };
  };
}
