{
  lib,
  config,
  ...
}:
{
  options.cfg.shell.mixed.fuzzel.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.cfg.shell.mixed.enable;
    description = "Installs and configures fuzzel";
  };
  config = lib.mkIf config.cfg.shell.mixed.fuzzel.enable {
      cfg.shell.launcher = "${lib.getExe config.programs.fuzzel.package}";
      programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          line-height = "30";
          prompt = "'     '";
          layer = "overlay";
          lines = "10";
          horizontal-pad = "10";
          vertical-pad = "10";
          inner-pad = "6";
          filter-desktop = "false";
          image-size-ratio = "0.5";
          fields = "name,exec";
          placeholder = "Search...";
          sort-result = "false";
          match-mode = "exact";
          dpi-aware = "false";
        };
        border = {
          radius = 6;
          width = 2;
        };
        key-bindings = {
          prev-with-wrap = "Up";
          next-with-wrap = "Down";
          prev = "None";
          next = "None";
        };
      };
    };
  };
}
