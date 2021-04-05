#!/bin/bash
set -xeuo pipefail
# SOURCE="https://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/os"
SOURCE="http://os.archlinuxarm.org/os"

function make-board() {
    NAME="ArchLinuxARM-$1-latest"
    ./scripts/precheck.py "$SOURCE/$NAME" || return
    ./scripts/download.sh "$SOURCE/$NAME"
    TIMESTAMP="$(stat -c %Z "$NAME.tar.gz")"
    LABEL="$(date +%Y%m --date "@${TIMESTAMP}")"
    SAVED_PATH="dist/${LABEL}-ArchLinuxARM-${2}.img"
    ./scripts/make-raspberry-pi-image.sh "$NAME" "$SAVED_PATH"
    pbzip2 --force "$SAVED_PATH"
}

make-board rpi "rpi-1"
make-board rpi-2 "rpi-2"
make-board rpi-4 "rpi-4"
