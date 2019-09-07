#!/bin/bash
set -xeuo pipefail

function make-board() {
    local NAME="ArchLinuxARM-$1-latest"
    local SAVED_PATH="dist/$(date +%Y%m)-ArchLinuxARM-${2}.img"
    ./scripts/download.sh "$NAME"
    ./scripts/make-raspberry-pi-image.sh "$NAME" "$SAVED_PATH"
    pbzip2 --force "$SAVED_PATH"
}

make-board rpi "rpi-1"
make-board rpi-2 "rpi-2"
make-board rpi-4 "rpi-4"
