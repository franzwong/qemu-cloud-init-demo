#!/bin/bash

cat <<EOF > /home/foo/.inputrc
"\e[A": history-search-backward
"\e[B": history-search-forward
EOF
