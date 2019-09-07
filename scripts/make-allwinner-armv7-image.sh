#!/bin/bash
set -xeuo pipefail

NAME="$1"
ROOTFS="$(mktemp -d)"

truncate --size 1900MiB "${NAME}.img"

parted --script "${NAME}.img" \
    unit S \
    mklabel msdos \
    mkpart primary ext4 8MiB 100%

LOOP=$(losetup --find --show "${NAME}.img")
partx --show "${LOOP}"
partx --add "${LOOP}"
mkfs.ext4 -F -O ^metadata_csum,^64bit "${LOOP}p1"
mount --types ext4 "${LOOP}p1" "${ROOTFS}"
bsdtar -xpf "${NAME}.tar.gz" -C "${ROOTFS}"
cp -r "files"/* "$ROOTFS"
sync
umount "${ROOTFS}"
rmdir "${ROOTFS}"
partx --delete "${LOOP}"
losetup --detach "${LOOP}"
