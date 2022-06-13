# What to do after setting up a new Droplet

## Basic Setup

### Create Droplet

`python do/do.py killcss.xyz --memory 1`
`ssh root@NEWIP`
`ssh malev@NEWIP`

### Basic Firewall

1.- Read the guide

## Docker

### Installation

1.- `poetry run ansible-playbook do/setup.yml -l do -K`

### Validation

1.- SSH into the server
2.- `sudo systemctl status docker` <- Validate that docker deamon is running
3.- `docker run hello-world` <- Testing docker

## Running Services

- Nginx: `make do_nginx`

## References

- [Initial Server Setup with Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-20-04)
- [UFW Essentials: Common Firewall Rules and Commands](https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands)
- [Set up a Production-Ready Droplet ](https://docs.digitalocean.com/tutorials/recommended-droplet-setup/)
