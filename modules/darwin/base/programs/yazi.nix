{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.yazi;
  toml = pkgs.formats.toml {};
in {
  options.cfg.programs.yazi.enable = mkEnableOption "yazi";

  config = mkIf cfg.enable {
    hj = {
      packages = [pkgs.yazi];
      xdg.config.files = {
        "yazi/init.lua".text = ''
          require("full-border"):setup()
          require("no-status"):setup()
          require("git"):setup()
        '';
        "yazi/plugins/full-border.yazi".source = pkgs.yaziPlugins.full-border;
        "yazi/plugins/git.yazi".source = pkgs.yaziPlugins.git;
        "yazi/plugins/no-status.yazi".source = pkgs.yaziPlugins.no-status;
        "yazi/yazi.toml".source = toml.generate "yazi-settings.toml" {
          yazi.plugin.prepend_fetchers = [
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
        "yazi/vfs.toml".source = toml.generate "yazi-vfs.toml" {
          sftp.aomori = {
            host = "aomori";
            user = "ari";
            port = 22;
          };
        };
        "yazi/keymap.toml".source = toml.generate "yazi-keymap.toml" {
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
