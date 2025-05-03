{
  config,
  lib,
  ...
}:
{
  options.cfg.cli.helix.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables helix the terminal editor";
  };
  imports = [
    ./languages.nix
  ];
  config = lib.mkIf config.cfg.cli.helix.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        editor = {
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          statusline = {
            left = [
              "mode"
              "version-control"
              "file-name"
              "spinner"
              "read-only-indicator"
            ];
            right = [
              "diagnostics"
              "selections"
              "register"
              "file-type"
              "position"
            ];
            mode.normal = "";
            mode.insert = "I";
            mode.select = "S";
          };
        };
        keys = {
          normal = {
            space = {
              space = "file_picker";
              q = ":write-quit-all";
              Q = ":quit!";
              w = ":write";
            };
          };
        };
      };
    };
  };
}
