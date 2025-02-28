#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
GENIMAGE_PATH="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

cp "${GENIMAGE_PATH}" "${BINARIES_DIR}/genimage.cfg"

mkdir -p -p "${BINARIES_DIR}/ssh"
ssh-keygen -q -N "" -t rsa -b 4096 -f "${BINARIES_DIR}/ssh/ssh_host_rsa_key"
ssh-keygen -q -N "" -t ecdsa -f "${BINARIES_DIR}/ssh/ssh_host_ecdsa_key"
ssh-keygen -q -N "" -t ed25519 -f "${BINARIES_DIR}/ssh/ssh_host_ed25519_key"

# idk man im just copy pasting from buildroot/board/raspberrypi4-64/post-image.sh
trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"

rm -rf "${GENIMAGE_TMP}"

genimage \
    --rootpath   "${ROOTPATH_TMP}"   \
    --tmppath    "${GENIMAGE_TMP}"   \
    --inputpath  "${BINARIES_DIR}"   \
    --outputpath "${BINARIES_DIR}"   \
    --config     "${BINARIES_DIR}/genimage.cfg"

exit $?
