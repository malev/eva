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

filebrowser:
	poetry run ansible-playbook local/filebrowser.yml -l local

homer:
	poetry run ansible-playbook local/homer.yml -l local

plex:
	poetry run ansible-playbook local/plex.yml -l local

pihole:
	poetry run ansible-playbook local/pihole.yml -l local

portainer:
	poetry run ansible-playbook local/portainer.yml -l local

nginx:
	poetry run ansible-playbook local/nginx.yml -l local

transmission:
	poetry run ansible-playbook local/transmission.yml -l local

uptime-kuma:
	poetry run ansible-playbook local/uptime-kuma.yml -l local

yatch:
	poetry run ansible-playbook local/yatch.yml -l local

linode:
	cd linode && terraform apply -var "linode_token=${LINODE_TOKEN}" -var "pvt_key=`cat $HOME/.ssh/id_rsa.pub`"

do_setup:
	poetry run ansible-playbook do/setup.yml -l do -K
do_nginx:
	poetry run ansible-playbook do/nginx.yml -l do
