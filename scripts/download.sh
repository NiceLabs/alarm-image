#!/bin/bash
set -xeuo pipefail
NAME="$1"
# SOURCE="https://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/os"
SOURCE="http://os.archlinuxarm.org/os"
LINK="${SOURCE}/${NAME}.tar.gz"
CHECKSUM="$(curl -sSL "${LINK}.md5" | cut -d ' ' -f 1)"
aria2c --continue --check-integrity --checksum="MD5=$CHECKSUM" "${LINK}"
