{
  lib,
  config,
  osConfig,
  ...
}:
{
  options.cfg.cli.zellij.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.cli.enable;
    description = "Installs and configures zellij";
  };
  config = lib.mkIf config.cfg.cli.zellij.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = osConfig.cfg.fish.enable;
    };    
  };
}
