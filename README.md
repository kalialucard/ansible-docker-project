# Ansible Docker Lab

A small, self-contained lab that demonstrates **Ansible automation** against multiple Docker containers.
It’s perfect for a portfolio: 1 control node (Ansible) + 5 Ubuntu target nodes, managed over SSH with a shared key.

Below is a ready-to-use `README.md` you can drop into your repo. I included **places to paste real terminal outputs** (or screenshots) as proof for each section — replace the placeholders with your recorded outputs.

---

## Repo structure

```
ansible-docker-lab/
├── ansible-control/         # Dockerfile & control setup
├── ansible-target/          # Dockerfile & target entrypoint
├── ansible/                 # Ansible project (hosts, playbook, ansible.cfg)
├── docker-compose.yml
├── ssh_keys/                # host-mounted folder (ADD TO .gitignore)
└── README.md
```

---

## Quick summary

* **What it is:** A lab to run Ansible playbooks against multiple Dockerized Ubuntu targets.
* **What it shows:** SSH key provisioning, inventory-driven automation, idempotent playbooks (nginx install + demo file + uptime).
* **Why it’s useful:** Portable demo for interviews / GitHub — no cloud infra required.

---

## Prerequisites

* Docker
* Docker Compose
* Basic familiarity with shell & Ansible

---

## Quickstart — run the lab

From repo root:

```bash
# create host ssh folder (do not commit private keys)
mkdir -p ssh_keys
chmod 700 ssh_keys

# build and run
docker compose up --build -d

# enter control container
docker exec -it ansible-control bash
```

**Proof to add:** terminal output of `docker compose up --build -d` and `docker ps`.
Example to paste (or screenshot):

```
$ docker ps
CONTAINER ID   IMAGE                            COMMAND                  CREATED         STATUS         PORTS     NAMES
be41279c349d   ansible-docker-project-ansible   "bash"                   4 minutes ago   Up 4 minutes             ansible-control
693b7db3c369   ansible-docker-project-target1   "/usr/local/bin/entr…"   4 minutes ago   Up 4 minutes             target1
3021b9bdcb7f   ansible-docker-project-target5   "/usr/local/bin/entr…"   4 minutes ago   Up 4 minutes             target5
862c0aecfcbd   ansible-docker-project-target2   "/usr/local/bin/entr…"   4 minutes ago   Up 4 minutes             target2
bfcb1a9527ab   ansible-docker-project-target3   "/usr/local/bin/entr…"   4 minutes ago   Up 4 minutes             target3
03b89ff204ce   ansible-docker-project-target4   "/usr/local/bin/entr…"   4 minutes ago   Up 4 minutes             target4
```

---

## Basic connectivity tests (paste your outputs here)

From inside `ansible-control` container:

1. **Ping each target**

```bash
ping -c 2 target1
ping -c 2 target2
# ...
```

Paste output here. Example:

```
PING target1 (172.27.0.5) 56(84) bytes of data.
64 bytes from target1.ansible-docker-project_default (172.27.0.5): icmp_seq=1 ttl=64 time=0.817 ms
64 bytes from target1.ansible-docker-project_default (172.27.0.5): icmp_seq=2 ttl=64 time=0.133 ms
```

2. **SSH into a target using the shared key**

```bash
ssh -i /shared_keys/id_rsa ansible@target1
```

Paste the SSH login proof (you can redact host keys). Example portion:

```
The authenticity of host 'target1 (172.27.0.5)' can't be established.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Welcome to Ubuntu 22.04.5 LTS ...
ansible@693b7db3c369:~$ exit
```

3. **Ansible ping module**

From control container:

```bash
ansible -i hosts all -m ping
```

Paste the output. Example:

```
target5 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
target4 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
...
```

---

## Run the demo playbook (what to run & proof)

From control container:

```bash
cd /home/ansible/project
ansible-playbook -i hosts playbook.yml
```

**Proof / paste the playbook output.** Example (trimmed):

```
PLAY [Demo playbook for portfolio] ***************************************************************

TASK [Gathering Facts] *******************************************************************************
ok: [target4]
ok: [target1]
ok: [target3]
ok: [target5]
ok: [target2]

TASK [update apt cache] *******************************************************************************
ok: [target1]
ok: [target5]
ok: [target2]
ok: [target3]
ok: [target4]

TASK [ensure nginx is installed] **********************************************************************
changed: [target3]
changed: [target5]
changed: [target1]
changed: [target4]
changed: [target2]

TASK [ensure nginx is started and enabled] ***********************************************************
changed: [target2]
changed: [target4]
changed: [target3]
changed: [target5]
changed: [target1]

TASK [drop a demo index.html] ************************************************************************
changed: [target3]
changed: [target2]
changed: [target5]
changed: [target1]
changed: [target4]

TASK [show uptime (for demo)] ************************************************************************
changed: [target5]
changed: [target2]
changed: [target3]
changed: [target1]
changed: [target4]

TASK [print uptime] **********************************************************************************
ok: [target1] => {
    "uptime_out.stdout": " 09:48:03 up  6:38,  0 users,  load average: 1.25, 0.97, 0.65"
}
...
PLAY RECAP *******************************************************************************************
target1 : ok=7 changed=4 ...
...
```
# ansible-docker-project
# ansible-docker-project
# ansible-docker-project
