{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cfg.system.greetd.enable = mkEnableOption "greetd";
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];
  config = mkIf config.cfg.system.greetd.enable {
    preservation.preserveAt."/persistent".directories = ["/var/lib/noctalia-greeter"];
    programs.noctalia-greeter.enable = true;
  };
}
