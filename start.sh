#!/bin/bash

source .env

if [[ ! -f "${IMAGE_FILE}" ]]; then
    echo "Cannot find image file!"
    exit 1
fi

if [[ ! -f "id_ed25519" || ! -f "id_ed25519.pub" ]]; then
    echo "Cannot find SSH key!"
    exit 1
fi

if [[ ! -f "cloud_init/build/content/${CLOUD_INIT_ISO_FILE}" ]]; then
    echo "Cannot find ${CLOUD_INIT_ISO_FILE}!"
    exit 1
fi

platform=$(uname -m)

if [[ "${platform}" == "arm64" ]]; then
    qemu-system-aarch64                                                                     \
        -machine type=virt-9.0,accel=hvf                                                    \
        -bios QEMU_EFI.fd                                                                   \
        -smp $(nproc)                                                                       \
        -cpu host                                                                           \
        -m 2048                                                                             \
        -nographic                                                                          \
        -hda "${IMAGE_FILE}"                                                                \
        -virtfs local,path=shared,mount_tag=shared,security_model=mapped                    \
        -drive file=cloud_init/build/content/${CLOUD_INIT_ISO_FILE},format=raw,if=virtio    \
        -netdev user,id=mynet0,hostfwd=tcp::2222-:22                                        \
        -device e1000,netdev=mynet0
else
    echo "Unsupported platform!" >&2
    exit 1
fi
