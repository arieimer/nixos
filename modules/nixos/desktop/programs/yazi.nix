{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.yazi;
in {
  options.cfg.programs.yazi.enable = mkEnableOption "yazi";
  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      plugins = {
        full-border = pkgs.yaziPlugins.full-border;
        git = pkgs.yaziPlugins.git;
        no-status = pkgs.yaziPlugins.no-status;
      };
      initLua = pkgs.writeText "yazi-init.lua" ''
        require("full-border"):setup()
        require("no-status"):setup()
        require("git"):setup()
      '';
      settings = {
        yazi = {
          plugin = {
            prepend_fetchers = [
              {
                url = "*";
                run = "git";
                group = "git";
              }
              {
                url = "*/";
                run = "git";
                group = "git";
              }
            ];
          };
        };
        vfs = {
          sftp.aomori = {
            host = "aomori";
            user = "ari";
            port = 22;
          };
        };
        keymap = {
          mgr.prepend_keymap = [
            {
              on = ["g" "s"];
              run = "cd sftp://aomori";
              desc = "Enter aomori";
            }
          ];
        };
      };
    };
  };
}
