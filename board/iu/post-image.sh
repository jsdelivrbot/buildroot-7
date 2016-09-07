#!/bin/sh

BOARD_DIR="$(dirname $0)"
ITS_FILE="/home/esgs/work/iu/hw/iu_sn01.its"

echo "${BINARIES_DIR}"
cd "${BINARIES_DIR}"

cp "${ITS_FILE}" .

# The kernel only understands the "legacy" version of lz4
"${HOST_DIR}/lz4" -9 -z -l rootfs.cpio > rootfs.cpio.lz4

mkimage -f `basename "${ITS_FILE}"` iu_sn01.itb

exit $?
