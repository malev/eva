terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.17.0"
    }
  }
}

variable "linode_token" {}
variable "pvt_key" {}

provider "linode" {
  token = var.linode_token
}

resource "linode_instance" "eva_instance" {
  label           = "eva02"
  image           = "linode/ubuntu20.04"
  region          = "us-central"
  type            = "g6-standard-1"
  tags            = ["eva"]
  authorized_keys = [var.pvt_key]
}

resource "linode_domain" "eva_domain" {
  domain    = "malev.xyz"
  soa_email = "marcosvanetta@gmail.com"
  type      = "master"
}

resource "linode_domain_record" "eva_domain_record" {
  domain_id   = linode_domain.eva_domain.id
  name        = "malev.xyz"
  record_type = "A"
  target      = linode_instance.eva_instance.id
  ttl_sec     = 300
}

resource "linode_firewall" "eva_firewall" {
  label = "eva"
  tags  = ["eva"]

  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ipv4     = ["0.0.0.0"]
    ipv6     = ["ff00::/8"]
  }

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.eva_instance.id]
}
