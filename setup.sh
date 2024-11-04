#!/bin/bash

source .env

platform=$(uname -m)
if [[ "${platform}" != "arm64" ]]; then
    echo "Only arm64 is supported" >&2
    exit 1
fi

# Download cloud image
curl -o "${IMAGE_FILE}.clean" "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-arm64.img"

# Generate SSH key
ssh-keygen -t ed25519 -C "${SSH_KEY_NAME}" -f "id_ed25519" -N '' <<< y

# Download QEMU EFI
curl -L -o QEMU_EFI.tar.gz https://gist.github.com/theboreddev/5f79f86a0f163e4a1f9df919da5eea20/raw/f546faea68f4149c06cca88fa67ace07a3758268/QEMU_EFI-cb438b9-edk2-stable202011-with-extra-resolutions.tar.gz
rm -rf QEMU_EFI
mkdir -p QEMU_EFI
tar -xzvf QEMU_EFI.tar.gz -C QEMU_EFI
cp QEMU_EFI/QEMU_EFI.fd .
rm -rf QEMU_EFI
rm QEMU_EFI.tar.gz
