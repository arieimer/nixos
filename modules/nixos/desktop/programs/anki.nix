{
  config,
  lib,
  ...
}: {
  imports = [../../../common/programs/anki];

  config = lib.mkIf config.cfg.programs.anki.enable {
    cfg.preservation.homeDirectories = [".local/share/Anki2"];
  };
}
