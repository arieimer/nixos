{
  osConfig,
  inputs,
  config,
  lib,
  ...
}:
{
  options.cfg.cli.yazi.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures yazi a TUI file manager";
  };
  config = lib.mkIf config.cfg.cli.yazi.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = osConfig.cfg.fish.enable;
      shellWrapperName = "y";
      plugins = {
        full-border = "${inputs.yazi-plugins}/full-border.yazi";
      };
      initLua = ''
        require("full-border"):setup()
      '';
    };
  };
}
