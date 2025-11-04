#!/bin/bash
set -e

# Make sure the shared volume exists and is writable
mkdir -p /shared_keys
chmod 700 /shared_keys

# Generate keypair if it doesn't exist
if [ ! -f /shared_keys/id_rsa ]; then
  ssh-keygen -t rsa -b 2048 -f /shared_keys/id_rsa -N "" -C "ansible_key"
  chmod 600 /shared_keys/id_rsa
  chmod 644 /shared_keys/id_rsa.pub
  echo "Generated SSH keypair in /shared_keys"
fi

exec bash
