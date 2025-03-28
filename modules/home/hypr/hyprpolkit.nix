{
  config,
  lib,
  ...
}:
{
  options.cfg.hypr.hyprpolkit.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs Hyprpolkitagnet and configures";
  };
  config = lib.mkIf config.cfg.hypr.hyprpolkit.enable {
    services.hyprpolkitagent.enable = true;
  };
}
