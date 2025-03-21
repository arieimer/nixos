{
  config,
  lib,
  ...
}:
{
  options.cfg.gui.helix.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enables helix the terminal editor";
  };
  config = lib.mkIf config.cfg.gui.helix.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        keys.normal = {
          space.space = "file_picker";
          space.x = ":x";
          space.w = ":w";
          space.q = ":q";
        };
        editor.cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        editor.statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "file-name"
          ];
        };
      };
    };
  };
}
