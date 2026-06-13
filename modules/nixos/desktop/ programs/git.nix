{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf types mkOption optionalAttrs;
in {
  options.cfg.programs.git.enable = mkEnableOption "git";
  options.cfg.user.email = mkOption {
    type = types.nullOr types.str;
    default = null;
  };
  config = mkIf config.cfg.programs.git.enable {
    programs.git = {
      enable = true;
      config = {
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
