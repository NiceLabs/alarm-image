#!/bin/bash
set -xeuo pipefail
NAME="$1"
BOARD_NAME="$2"
SAVED_PATH="${3:-${2}.img}"

cp "${NAME}.img" "${SAVED_PATH}"
dd \
    if="scripts/u-boot-sunxi-with-spl/${BOARD_NAME}.bin" \
    of="${SAVED_PATH}" \
    bs=1024 \
    seek=8 \
    conv=notrunc
