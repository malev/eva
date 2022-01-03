env:
	poetry install

setup_digitalocean:
	poetry run ansible-playbook playbooks/setup.yml -l droplets --user root
	poetry run ansible-playbook playbooks/apt.yml -l droplets
	poetry run ansible-playbook playbooks/dependencies.yml -l droplets
	poetry run ansible-playbook playbooks/docker.yml -l ddroplets
