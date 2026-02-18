#!/bin/bash

HOST_KEY="$HOME/.ssh/id_rsa.pub"

if [ -f "$HOST_KEY" ]; then
    echo "Injecting SSH key from $HOST_KEY..."

    mkdir -p "${TARGET_DIR}/root/.ssh"

    cat "$HOST_KEY" >> "${TARGET_DIR}/root/.ssh/authorized_keys"

    chmod 700 "${TARGET_DIR}/root"
    chmod 700 "${TARGET_DIR}/root/.ssh"
    chmod 600 "${TARGET_DIR}/root/.ssh/authorized_keys"
else
    echo "WARNING: No SSH key found at $HOST_KEY. Skipping injection."
fi
