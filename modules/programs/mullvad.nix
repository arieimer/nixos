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
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    systemd.services.mullvad-daemon.postStart = let
      mullvad = config.services.mullvad-vpn.package;
    in ''
      while ! ${mullvad}/bin/mullvad status >/dev/null; do sleep 1; done
        ${mullvad}/bin/mullvad account login \
        "$(cat ${config.sops.secrets.mullvad.path})"
    '';
  };
}
