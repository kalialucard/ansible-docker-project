# Base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-server \
        sudo \
        python3 \
        iputils-ping && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create ansible user
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create sshd run directory
RUN mkdir -p /var/run/sshd

# Mount point for shared SSH keys
VOLUME ["/shared_keys"]

# Copy entrypoint
COPY entrypoint-target.sh /usr/local/bin/entrypoint-target.sh
RUN chmod +x /usr/local/bin/entrypoint-target.sh

ENTRYPOINT ["/usr/local/bin/entrypoint-target.sh"]
