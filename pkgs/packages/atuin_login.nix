{
  writeShellApplication,
  atuin,
  userFile,
  passwordFile,
  keyFile,
}:
writeShellApplication {
  name = "atuin_login";
  runtimeInputs = [atuin];
  text = ''
    session_file="''${XDG_DATA_HOME:-$HOME/.local/share}/atuin/session"

    if [ -f "$session_file" ]; then
      echo "atuin_login: already logged in, skipping"
      exit 0
    fi

    atuin login \
      --username "$(cat ${userFile})" \
      --password "$(cat ${passwordFile})" \
      --key "$(cat ${keyFile})"
  '';
}
