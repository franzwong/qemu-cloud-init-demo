#!/bin/bash

cd /mnt/shared/build/content

cloud-init devel make-mime \
    -a config.yaml:cloud-config \
    -a init_user.sh:x-shellscript > user-data

genisoimage -output "${CLOUD_INIT_ISO_FILE}" -volid cidata -input-charset utf-8 -joliet -rock user-data meta-data
