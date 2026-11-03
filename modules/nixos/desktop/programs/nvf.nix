{
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.nvf.nixosModules.default
    self.nixosModules.nvf-common
  ];
}
