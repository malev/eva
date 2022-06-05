# What to do after setting up a new Droplet

## Basic Setup

### As Root

1.- `ssh root@your_server_ip`
2.- `adduser malev`
3.- `usermod -aG sudo malev`
4.- `rsync --archive --chown=malev:malev ~/.ssh /home/malev`

### As a non-root user

1.- `ssh malev@your_server_ip`
2.- `sudo ls` <- Validate the user has sudo access

### As Root (disable root login)

1.- Edit `/etc/ssh/sshd_config`

- Validate `PasswordAuthentication no`
- Validate `PermitRootLogin no`
  2.- Restart the server
  3.- Validate that `ssh root@your_server_ip` is not longer working

### Basic Firewall

1.- Read the guide

## Docker

### Installation

1.- `sudo apt update`
2.- `sudo apt install apt-transport-https ca-certificates curl software-properties-common`
3.- `sudo apt install docker.io`
4.- `sudo systemctl status docker` <- Validate that docker deamon is running

### Run it without sudo

1.- `sudo usermod -aG docker ${USER}`
2.- `su - ${USER}`
3.- `groups` <- Validate that the docker group os present
4.- `docker run hello-world` <- Testing docker

### Installing Docker Compose

1.- `sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`
2.- `sudo chmod +x /usr/local/bin/docker-compose`
3.- `docker-compose --version` <- Validate it's been installed

### Installing Python dependencies

1.- `poetry run ansible-playbook do/setup.yml -l do -K`

## Running Services

- Nginx: `make do_nginx`

## References

- [Initial Server Setup with Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-20-04)
- [UFW Essentials: Common Firewall Rules and Commands](https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands)
