{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf types mkOption optionalAttrs;
  cfg = config.cfg.programs.git;
in {
  options.cfg.programs.git.enable = mkEnableOption "git";
  options.cfg.user.email = mkOption {
    type = types.nullOr types.str;
    default = null;
  };
  config = mkIf cfg.enable {
    hj.packages = [pkgs.delta];
    programs.git = {
      enable = true;
      config = {
        core.pager = "delta";
        interactive.diffFilter = "delta --color-only";
        delta = {
          navigate = true;
          line-numbers = true;
        };
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
        user =
          {
            name = config.cfg.user.username;
            user.signingKey = "/home/${config.cfg.user.username}/.ssh/id_ed25519";
            commit.gpgsign = true;
            gpg.format = "ssh";
          }
          // optionalAttrs (config.cfg.user.email != null) {
            email = config.cfg.user.email;
          };
      };
    };
  };
}
