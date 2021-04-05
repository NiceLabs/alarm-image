#!/bin/bash
set -xeuo pipefail
NAME="ArchLinuxARM-armv7-latest"
# SOURCE="https://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/os"
SOURCE="http://os.archlinuxarm.org/os"
./scripts/precheck.py "$SOURCE/$NAME"
./scripts/download.sh "$SOURCE/$NAME"
./scripts/make-allwinner-armv7-image.sh "$NAME"

TIMESTAMP="$(stat -c %Z "$NAME.tar.gz")"
LABEL="$(date +%Y%m --date "@${TIMESTAMP}")"

function make-board() {
    CODE_NAME="$1"
    SAVED_PATH="dist/${LABEL}-ArchLinuxARM-${CODE_NAME}.img"
    ./scripts/make-allwinner-armv7-board.sh "${NAME}" "${CODE_NAME}" "${SAVED_PATH}"
    pbzip2 --force "${SAVED_PATH}"
}

make-board "bananapi-m2-zero"
make-board "nanopi-m1"
make-board "nanopi-neo"
make-board "nanopi-neo-air"
make-board "orangepi-lite"
make-board "orangepi-one"
make-board "orangepi-r1"
make-board "orangepi-zero"
