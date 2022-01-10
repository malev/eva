env:
	poetry install

provision_digitalocean:
	cd digitalocean && terraform apply -var "do_token=${DO_PAT}" -var "pvt_key=$$HOME/.ssh/id_rsa"

destroy_digitalocean:
	cd digitalocean && terraform destroy -var "do_token=${DO_PAT}" -var "pvt_key=$$HOME/.ssh/id_rsa"

setup_digitalocean:
	poetry run ansible-playbook playbooks/setup.yml -l digitalocean --user root --private-key=~/.ssh/id_rsa-terraform
	poetry run ansible-playbook playbooks/apt.yml -l digitalocean
	poetry run ansible-playbook playbooks/dependencies.yml -l digitalocean
	poetry run ansible-playbook playbooks/docker.yml -l digitalocean

homer:
	poetry run ansible-playbook local/homer.yml -l local

traefik:
	poetry run ansible-playbook local/traefik.yml -l local

plex:
	poetry run ansible-playbook local/plex.yml -l local

pihole:
	poetry run ansible-playbook local/pihole.yml -l local

nginx:
	poetry run ansible-playbook local/nginx.yml -l local
