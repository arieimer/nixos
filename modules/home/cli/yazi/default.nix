{
  config,
  pkgs,
  lib,
  ...
}:
let
  plugins-repo = pkgs.fetchFromGitHub {
    # Grabbed on March 26 2025
    owner = "yazi-rs";
    repo = "plugins";
    rev = "273019910c1111a388dd20e057606016f4bd0d17";
    hash = "sha256-80mR86UWgD11XuzpVNn56fmGRkvj0af2cFaZkU8M31I=";
  };
in
{
  options.cfg.cli.yazi.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures yazi a TUI file manager";
  };
  config = lib.mkIf config.cfg.cli.yazi.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      shellWrapperName = "y";
      plugins = {
        full-border = "${plugins-repo}/full-border.yazi";
      };
      initLua = ''
        require("full-border"):setup()
      '';
    };
  };
}
