{
  lib,
  ...
}:
{
  options.cfg.gpu.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures gpu drivers for the selected platform";
  };
  options.cfg.gpu.type = lib.mkOption {
    type = lib.types.enum [
      "amd"
      "nvidia"
      "intel"
    ];
    default = null;
    description = "Supported gpu types are amd, nvidia, and intel.";
  };
  imports = [
    ./nvidia
    ./amd
    ./intel
  ];
}
