{
  writeShellApplication,
  nixos-anywhere,
}:
writeShellApplication {
  name = "install";
  runtimeInputs = [nixos-anywhere];
  text = ''

    HOST=''${1:?Usage: install.sh <host> <target-ip>}
    TARGET=''${2:?Usage: install.sh <host> <target-ip>}

    temp=$(mktemp -d)
    cleanup() { rm -rf "$temp"; }
    trap cleanup EXIT

    install -d -m700 "$temp/persistent/etc/sops/age"
    cp /etc/sops/age/keys.txt "$temp/persistent/etc/sops/age/keys.txt"
    chmod 600 "$temp/persistent/etc/sops/age/keys.txt"

    nixos-anywhere \
      --extra-files "$temp" \
      --flake ".#$HOST" \
      root@"$TARGET"
  '';
}
