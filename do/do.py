import json
import os
import requests
import argparse
from pathlib import Path

class BearerAuth(requests.auth.AuthBase):
    def __init__(self, token):
        self.token = token
    def __call__(self, r):
        r.headers["authorization"] = "Bearer " + self.token
        return r

ACCESS_TOKEN = os.environ.get('DIGITALOCEAN_TOKEN')

if ACCESS_TOKEN == "":
    sys.exit("Missing DO access token")

BASE_URL = "https://api.digitalocean.com/v2/"

DROPLETS_PATH = "droplets"
SSH_KEYS_PATH = "account/keys"

def get_ssh_keys():
    response = requests.get(BASE_URL + SSH_KEYS_PATH, auth=BearerAuth(ACCESS_TOKEN))
    return [ ssh_key['id'] for ssh_key in response.json()['ssh_keys'] ]


parser = argparse.ArgumentParser(description='Create a new Droplet.')
parser.add_argument('name', action = 'store', metavar='name', type=str, help='Name of your droplet')
parser.add_argument('--memory', type=int, help='Memory: 1, 2, or 4 (Gb)', default=1)

args = parser.parse_args()
print("Creating", args.name, "with", args.memory, "Gb")
print("Getting ssh keys...")
ssh_keys = get_ssh_keys()
print("Loading initial script...")
file = open(os.path.join(Path(__file__).parent.absolute(), "cloud-config.sh"), "r")

payload = {
    "name": args.name,
    "region": "nyc3",
    "size": "s-1vcpu-{}gb-intel".format(args.memory),
    "image": "ubuntu-22-04-x64",
    "ssh_keys": ssh_keys,
    "backups": False,
    "ipv6": True,
    "monitoring": True,
    "user_data": file.read(),
}

print("Creating Droplet")
response = requests.post(BASE_URL + DROPLETS_PATH, auth=BearerAuth(ACCESS_TOKEN), data=payload)
print(response.status_code)
print(json.dumps(response.json(), indent=4))
