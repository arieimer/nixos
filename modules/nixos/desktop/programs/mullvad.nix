{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.cfg.programs.mullvad;
in {
  options.cfg.programs.mullvad = {
    enable = mkEnableOption "mullvad-vpn";
  };
  config = mkIf cfg.enable {
    cfg.preservation.directories = ["/etc/mullvad-vpn"];
    systemd.services.mullvad-daemon.postStart = let
      mullvad = config.services.mullvad-vpn.package;
    in ''
      while ! ${mullvad}/bin/mullvad status >/dev/null; do sleep 1; done
        ${mullvad}/bin/mullvad account login \
        "$(cat ${config.sops.secrets.mullvad.path})"
    '';

    services.mullvad-vpn = {
      enable = true;
      gui.enable = true;
    };
    sops.secrets."mullvad".owner = config.cfg.user.username;
  };
}
