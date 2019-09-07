#!/bin/bash
set -x
fdisk /dev/mmcblk0 <<EOF
d
n
p
1
16384

w
EOF
resize2fs /dev/mmcblk0p1
