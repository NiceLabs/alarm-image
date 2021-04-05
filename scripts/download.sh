#!/bin/bash
set -xeuo pipefail
LINK="$1.tar.gz"
CHECKSUM="$(curl -sSL "${LINK}.md5" | cut -d ' ' -f 1)"
aria2c --continue --remote-time --check-integrity --checksum="MD5=$CHECKSUM" "${LINK}"
