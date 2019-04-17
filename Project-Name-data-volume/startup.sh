#!/bin/bash

mkdir -p /mnt/XXXXXX/frugo
mkdir -p /mnt/XXXXXX/jnj
mkdir -p /mnt/XXXXXX/sxt
mkdir -p /mnt/XXXXXX/amzn

chown -R Project-Name: /mnt/XXXXXX
echo -e "Created required folder structure in data volume container\n"

tail -f /dev/null
