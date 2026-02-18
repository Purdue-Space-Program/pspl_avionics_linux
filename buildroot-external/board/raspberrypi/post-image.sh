#!/bin/bash
set -e

BOARD_DIR="$(dirname $0)"
GENIMAGE_PATH="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
ROOTPATH="${TARGET_DIR}"

rm -rf "${GENIMAGE_TMP}"

genimage \
    --rootpath   "${ROOTPATH}"     \
    --tmppath    "${GENIMAGE_TMP}" \
    --inputpath  "${BINARIES_DIR}" \
    --outputpath "${BINARIES_DIR}" \
    --config     "${GENIMAGE_PATH}"
