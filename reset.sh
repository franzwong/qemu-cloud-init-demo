#!/bin/bash

source .env

rm -f "${IMAGE_FILE}"
cp "${IMAGE_FILE}.clean" "${IMAGE_FILE}"
qemu-img resize "${IMAGE_FILE}" +50G

sed -i '/\[localhost\]:2222/d' ~/.ssh/known_hosts

cd cloud_init; bash generate_iso.sh
