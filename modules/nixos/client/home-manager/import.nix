{
  hostname,
  ...
}:
{
  imports = [
    ../../../../hosts/${hostname}/home.nix
    ../../../home
  ];
}
