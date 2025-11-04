#!/bin/bash
set -e

# Create SSH directory for ansible user
mkdir -p /home/ansible/.ssh

# Copy public key if exists
if [ -f /shared_keys/id_rsa.pub ]; then
    cat /shared_keys/id_rsa.pub >> /home/ansible/.ssh/authorized_keys
fi

# Set permissions
chown -R ansible:ansible /home/ansible/.ssh
chmod 700 /home/ansible/.ssh
chmod 600 /home/ansible/.ssh/authorized_keys

# Start SSH server in foreground
exec /usr/sbin/sshd -D
