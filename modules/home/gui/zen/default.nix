{
  inputs,
  system,
  config,
  lib,
  ...
}:
{
  options.cfg.gui.zen-browser.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs firefox";
  };
  config = lib.mkIf config.cfg.gui.zen-browser.enable {
    home.packages = [
      # Zen browser is not officially packaged so cannot be configured with home-manager.
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
