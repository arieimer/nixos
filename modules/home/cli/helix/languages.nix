{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = lib.mkIf config.cfg.cli.helix.enable {
    programs.helix = {
      languages = {
        language = [
          {
            name = "nix";
            language-servers = [ "nil" ];
          }
          {
            name = "bash";
          }
          {
            name = "rust";
            language-servers = [ "rust-analyzer" ];
          }
        ];
        language-server = {
          nil = {
            command = lib.getExe pkgs.nil;
          };
          bash-language-server = {
            command = lib.getExe pkgs.bash-language-server;
            args = [ "start" ];
          };
          rust-analyzer = {
            command = lib.getExe pkgs.rust-analyzer;
          };
        };
      };
    };
  };
}
