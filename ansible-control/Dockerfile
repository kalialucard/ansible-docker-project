# Base image
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-client \
        ssh \
        sudo \
        python3 \
        python3-pip \
        python3-apt \
        ansible \
        iputils-ping \
        git \
        vim \
        curl \
        net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create ansible user
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set working directory
WORKDIR /home/ansible/project

# Mount point for SSH keys
VOLUME ["/shared_keys"]

# Switch to ansible user
USER ansible

# Default command
CMD ["bash"]
