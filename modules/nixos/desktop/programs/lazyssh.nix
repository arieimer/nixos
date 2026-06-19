{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.programs.lazyssh.enable = mkEnableOption "lazyssh";
  config = mkIf config.cfg.programs.lazyssh.enable {
    hj = {
      packages = [pkgs.lazyssh];
      files.".ssh/config".text = ''
        Host katei
          HostName 192.168.0.57
          Port 22
          IdentityFile ~/.ssh/id_ed25519
      '';
    };
  };
}
