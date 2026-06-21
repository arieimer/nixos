{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.lazyssh;
in {
  options.cfg.programs.lazyssh.enable = mkEnableOption "lazyssh";
  config = mkIf cfg.enable {
    hj = {
      packages = [pkgs.lazyssh];
      files.".ssh/config".text = ''
        Host *
        SetEnv TERM=xterm-256color

        Host katei
          HostName 192.168.0.57
          Port 22
          IdentityFile ~/.ssh/id_ed25519
      '';
    };
  };
}
