{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.atuin;
in {
  options.cfg.programs.atuin.enable = mkEnableOption "atuin";
  config = mkIf cfg.enable {
    cfg.preservation.homeDirectories = [".local/share/atuin"];
    programs.atuin = {
      enable = true;
      settings = {
        auto_sync = true;
        sync_frequency = "1m";
        sync_address = "https://atuin.arieimer.net";
        search_mode = "fuzzy";
      };
    };
    sops.secrets = {
      "atuin/username".owner = config.cfg.user.username;
      "atuin/password".owner = config.cfg.user.username;
      "atuin/key".owner = config.cfg.user.username;
    };
    hj.packages = [
      (pkgs.callPackage ../../../../pkgs/packages/atuin_login.nix {
        userFile = config.sops.secrets."atuin/username".path;
        passwordFile = config.sops.secrets."atuin/password".path;
        keyFile = config.sops.secrets."atuin/key".path;
      })
    ];
  };
}
