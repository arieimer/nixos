{
  config,
  inputs,
  ...
}: {
  imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

  nix-homebrew = {
    enable = true;
    user = config.cfg.user.username;
    autoMigrate = true;
  };

  homebrew.enable = true;
}
