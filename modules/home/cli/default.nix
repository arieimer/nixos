{
  config,
  username,
  osConfig,
  pkgs,
  lib,
  ...
}:
{
  options.cfg.cli.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures several CLI tools";
  };
  options.cfg.cli.bat.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.cli.enable;
    description = "bat the cat replacement";
  };
  options.cfg.cli.eza.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.cli.enable;
    description = "eza the ls replacement";
  };
  options.cfg.cli.git.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.cli.enable;
    description = "git";
  };
  options.cfg.cli.git.username = lib.mkOption {
    type = lib.types.str;
    default = "${username}";
    description = "git username";
  };
  options.cfg.cli.git.email = lib.mkOption {
    type = lib.types.str;
    default = "REPLACEME@example.com";
    description = "git username";
  };
  options.cfg.cli.btop.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.cli.enable;
    description = "Installs and configures btop";
  };
  options.cfg.cli.direnv.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Installs and configures direnv";
  };

  imports = [
    ./fastfetch
    ./helix
    ./yazi
    ./fish
    ./zellij
  ];
  config = lib.mkIf config.cfg.cli.enable {
    home.packages = [
      # Perhaps should be made optional but they are very good to have
      pkgs.p7zip-rar
      pkgs.dua
      pkgs.caligula
    ];
    programs.direnv = lib.mkIf config.cfg.cli.direnv.enable {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
      config.global.hide_env_diff = true;
    };
    programs.bat.enable = config.cfg.cli.bat.enable;
    programs.btop.enable = config.cfg.cli.btop.enable;
    programs.eza = lib.mkIf config.cfg.cli.eza.enable {
      enable = true;
      enableFishIntegration = osConfig.cfg.fish.enable;
      icons = "always";
      colors = "always";
      extraOptions = [ "--group-directories-first" ];
    };
    programs.git = lib.mkIf config.cfg.cli.git.enable {
      enable = true;
      userName = config.cfg.cli.git.username;
      userEmail = config.cfg.cli.git.email;
    };
  };
}
