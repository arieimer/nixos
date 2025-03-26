{
  options,
  config,
  username,
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
  options.cfg.cli.yazi.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.cli.enable;
    description = "Installs yazi";
  };

  imports = [
    ./fastfetch
    ./helix
    # ./yazi not neccessary until plugins are figured out
  ];
  config = lib.mkIf config.cfg.cli.enable {
    home.packages = [ # Perhaps should be made optional but they are very good to have
      pkgs.p7zip-rar
      pkgs.dua
      pkgs.caligula
      #pkgs.lm_sensors 
    ];
    programs.fish = {
      enable = true;
      shellAliases = {
        ls = lib.mkIf config.cfg.cli.eza.enable "eza";
        cat = lib.mkIf config.cfg.cli.bat.enable "bat";
        "..." = "cd ../..";
      };
    };
    programs.bat.enable = lib.mkIf config.cfg.cli.bat.enable true;
    programs.yazi.enable = lib.mkIf config.cfg.cli.yazi.enable true;
    programs.eza = lib.mkIf config.cfg.cli.eza.enable {
      enable = true;
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
