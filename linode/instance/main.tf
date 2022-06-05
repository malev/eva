resource "linode_instance" "eva_instance" {
  label           = "eva02"
  image           = "linode/ubuntu20.04"
  region          = "us-central"
  type            = "g6-nanode-1"
  tags            = ["eva"]
  authorized_keys = [var.pvt_key]
}

resource "linode_domain" "eva_domain" {
  domain    = "malev.xyz"
  type      = "master"
}

resource "linode_domain_record" "eva_domain_record" {
  domain_id   = linode_domain.eva_domain.id
  name        = "www"
  record_type = "CNAME"
  target      = "malev.xyz"
  ttl_sec     = 300
}

resource "linode_firewall" "eva_firewall" {
  label = "eva"
  tags  = ["eva"]

  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["ff00::/8"]
  }

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.eva_instance.id]
}
