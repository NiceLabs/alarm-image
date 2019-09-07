#!/bin/bash
set -xeuo pipefail

NAME="$1"
SAVED_PATH="${2:-${1}.img}"

BOOT=$(mktemp -d)
ROOT=$(mktemp -d)

truncate --size 1900MiB "${SAVED_PATH}"

parted --script "${SAVED_PATH}" \
    unit S \
    mklabel msdos \
    mkpart primary fat32 2048 100MiB \
    mkpart primary ext4 100MiB 100%

LOOP=$(losetup --find --show "${SAVED_PATH}")
partx --show "${LOOP}"
partx --add "${LOOP}"
mkfs.vfat -I "${LOOP}p1"
mkfs.ext4 -F "${LOOP}p2"
mount --types vfat "${LOOP}p1" "${BOOT}"
mount --types ext4 "${LOOP}p2" "${ROOT}"
bsdtar -xpf "${NAME}.tar.gz" -C "${ROOT}"
mv "${ROOT}/boot"/* "${BOOT}"
cp -r "files/root" "${ROOT}"
sync
umount "${BOOT}" "${ROOT}"
rmdir "${BOOT}" "${ROOT}"
partx --delete "${LOOP}"
losetup --detach "${LOOP}"
