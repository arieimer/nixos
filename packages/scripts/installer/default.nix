{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "install-profile";
      runtimeInputs = [
        pkgs.git
        pkgs.gum
        pkgs.disko
      ];
      text = builtins.readFile ./install-profile.sh;
    })
  ];
}
