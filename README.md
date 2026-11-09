# Ansible Docker Lab 🤖

> A self-contained Ansible automation lab: one control node driving five Ubuntu Docker targets over SSH, with idempotent playbooks you can run from your laptop.

[![Ansible](https://img.shields.io/badge/Ansible-2.x-red?logo=ansible)](https://www.ansible.com/)
[![Docker](https://img.shields.io/badge/Docker-Compose-blue?logo=docker)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## What It Does

Spinning up a real Ansible environment usually requires multiple VMs or cloud instances. This lab runs everything in Docker Compose — one control node with Ansible installed and five identical Ubuntu target nodes, all connected over a shared SSH key. It's a portable portfolio demo that runs on any machine with Docker.

## Screenshot

<!-- TODO: add a screenshot of `ansible-playbook` output here -->
![Ansible run output](docs/screenshot.png)

## Architecture

```
docker-compose.yml
├── control   (ansible-control image)  ← runs playbooks
├── target1   (ansible-target image)   ← Ubuntu 22.04
├── target2
├── target3
├── target4
└── target5
```

The control node and all targets share a Docker network. The SSH public key is injected into each target at startup via a shared volume mount.

## Repo Structure

```
ansible-docker-project/
├── ansible-control/        # Dockerfile for the Ansible control node
├── ansible-target/         # Dockerfile + entrypoint for target nodes
├── ansible/
│   ├── hosts               # Inventory file
│   ├── playbook.yml        # Main playbook (nginx, demo file, uptime)
│   └── ansible.cfg
├── docker-compose.yml
└── ssh_keys/               # Host-mounted SSH keys (gitignored)
```

## Prerequisites

- Docker Engine + Docker Compose v2
- Ports 22 not needed externally — all traffic is internal to the Docker network

## Installation & Usage

```bash
git clone https://github.com/kalialucard/ansible-docker-project.git
cd ansible-docker-project

# Generate an SSH key pair for the lab
mkdir -p ssh_keys
ssh-keygen -t ed25519 -f ssh_keys/id_ed25519 -N ""

# Start all containers
docker compose up -d

# Exec into the control node
docker compose exec control bash

# Inside control node — run the playbook
ansible-playbook -i /ansible/hosts /ansible/playbook.yml
```

The playbook installs **nginx** on all targets, deploys a demo HTML file, and prints uptime — demonstrating idempotent, inventory-driven automation.

## Contributing

PRs welcome. Open an issue first for large changes.

## License

[MIT](LICENSE) © kalialucard
