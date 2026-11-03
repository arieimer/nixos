{
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.nvf.darwinModules.default
    self.darwinModules.nvf-common
  ];
}
