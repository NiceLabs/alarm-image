#!/bin/bash
set -xeuo pipefail
NAME="ArchLinuxARM-armv7-latest"
./scripts/download.sh "$NAME"
./scripts/make-allwinner-armv7-image.sh "$NAME"

function make-board() {
    local CODE_NAME="$1"
    local SAVED_PATH="dist/$(date +%Y%m)-ArchLinuxARM-${CODE_NAME}.img"
    ./scripts/make-allwinner-armv7-board.sh "${NAME}" "${CODE_NAME}" "${SAVED_PATH}"
    pbzip2 --force "${SAVED_PATH}"
}

make-board "bananapi-m2-zero"
make-board "nanopi-m1"
make-board "nanopi-neo-air"
make-board "nanopi-neo"
make-board "orangepi-lite"
make-board "orangepi-one"
make-board "orangepi-r1"
make-board "orangepi-zero"
