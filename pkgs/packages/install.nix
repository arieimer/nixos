{
  writeShellApplication,
  nixos-anywhere,
}:
writeShellApplication {
  name = "install";
  runtimeInputs = [nixos-anywhere];
  text = ''
    persist=1
    args=()
    for arg in "$@"; do
      case "$arg" in
        --no-persist)
          persist=0
          ;;
        *)
          args+=("$arg")
          ;;
      esac
    done

    HOST=''${args[0]:?Usage: install.sh [--no-persist] <host> <target-ip>}
    TARGET=''${args[1]:?Usage: install.sh [--no-persist] <host> <target-ip>}

    temp=$(mktemp -d)
    cleanup() { rm -rf "$temp"; }
    trap cleanup EXIT

    if [ "$persist" -eq 1 ]; then
      dest="$temp/persistent/etc/sops/age"
    else
      dest="$temp/etc/sops/age"
    fi

    install -d -m700 "$dest"
    cp /etc/sops/age/keys.txt "$dest/keys.txt"
    chmod 600 "$dest/keys.txt"

    nixos-anywhere \
      --extra-files "$temp" \
      --flake ".#$HOST" \
      root@"$TARGET"
  '';
}
