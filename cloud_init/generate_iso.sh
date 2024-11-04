#!/bin/bash

source ../.env

rm -rf build

mkdir -p build

mkdir -p build/content

cp scripts/* build/content/

public_key=$(cat "../id_ed25519.pub")

sed 's/<PUBLIC_KEY_HERE>/'"${public_key}"'/' config.yaml > build/content/config.yaml

cat <<EOF > build/content/meta-data
local-hostname: ${HOSTNAME}
EOF

docker build -t local/cloud_init .

docker run --rm --name create_cloud_init_iso -e CLOUD_INIT_ISO_FILE="${CLOUD_INIT_ISO_FILE}" -v $(pwd):/mnt/shared local/cloud_init
