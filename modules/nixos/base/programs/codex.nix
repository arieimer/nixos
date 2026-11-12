{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cfg.programs.codex;
in {
  options.cfg.programs.codex.enable = mkEnableOption "Codex CLI";

  config = mkIf cfg.enable {
    hj.packages = [inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex];
  };
}
