{
  lib,
  fetchurl,
  writeShellApplication,
  makeDesktopItem,
  symlinkJoin,
  coreutils,
  jdk17,
  ffmpeg,
}: let
  bootstrap = fetchurl {
    url = "https://installer.jdownloader.org/JDownloader.jar";
    hash = "sha256-OIodAo5ly8Y5M6d43bySZ8FOfnhYOJzjGhC+cwit60A=";
  };
  launcher = writeShellApplication {
    name = "jdownloader2";
    runtimeInputs = [coreutils jdk17 ffmpeg];
    text = ''
      # JDownloader updates itself, so its installation must be writable.
      data_dir="''${XDG_DATA_HOME:-$HOME/.local/share}/jdownloader2"
      mkdir -p "$data_dir"
      if [ ! -e "$data_dir/JDownloader.jar" ]; then
        install -m644 ${bootstrap} "$data_dir/JDownloader.jar"
      fi
      cd "$data_dir"
      exec java -jar "$data_dir/JDownloader.jar" "$@"
    '';
  };
  desktopItem = makeDesktopItem {
    name = "jdownloader2";
    desktopName = "JDownloader 2";
    comment = "Download manager";
    exec = "jdownloader2";
    terminal = false;
    categories = ["Network" "FileTransfer"];
  };
in
  symlinkJoin {
    name = "jdownloader2";
    paths = [launcher desktopItem];
    meta = {
      description = "Download manager with a self-updating installation";
      homepage = "https://jdownloader.org/";
      sourceProvenance = [lib.sourceTypes.binaryBytecode];
      license = lib.licenses.unfree;
      platforms = lib.platforms.linux;
      mainProgram = "jdownloader2";
    };
  }
