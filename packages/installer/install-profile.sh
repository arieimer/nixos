#!/usr/bin/env bash
#

if [ "$(id -u)" -eq 0 ]; then
  echo "This should not be run with sudo or as root..."
  exit 1
fi

git clone https://github.com/ari-rs/nixconfig.git "$HOME/nixconfig"

TARGET_PROFILE=$(find ~/nixconfig/hosts -mindepth 1 -maxdepth 1 -type d ! -name default -exec basename {} \; | gum choose)

gum confirm  --default=false "This will install $TARGET_PROFILE please verify this is correct."

echo "Starting install process..."

if [ "$TARGET_PROFILE" == "detlas" ]; then
  sudo disko-install --flake nixconfig#detlas --disk main /dev/disk/by-id/nvme-WD_Blue_SN570_500GB_222622801561
fi
