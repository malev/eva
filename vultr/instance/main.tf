resource "vultr_instance" "eva" {
  plan     = "vc2-1c-2gb"
  region   = "dfw" # Dallas
  os_id    = "387" # Ubuntu 20.04 x64
  label    = "eva03"
  tag      = "eva"
  hostname = "killcss.xyz"
  ssh_key_ids = ["ee2891a9-f201-4273-933c-5d78238efe9b"]
}

resource "vultr_firewall_group" "fwg" {
  description = "docker-fwg"
}

resource "vultr_firewall_rule" "tcp" {
  firewall_group_id = vultr_firewall_group.fwg.id
  protocol          = "udp"
  subnet            = vultr_instance.eva.main_ip
  subnet_size       = 32
  port              = "8080"
  ip_type           = "v4"
}

resource "vultr_dns_domain" "killcss" {
  domain    = "tf-domain.com"
  ip        = vultr_instance.eva.main_ip
}

resource "vultr_dns_record" "a-record" {
  data   = vultr_instance.eva.main_ip
  domain = vultr_dns_domain.killcss.id
  name   = "www"
  type   = "A"
  ttl    = 3600
}

resource "vultr_load_balancer" "lb" {
  region              = "ewr"
  label               = "terraform lb example"
  balancing_algorithm = "roundrobin"

  forwarding_rules {
    frontend_protocol = "http"
    frontend_port     = 80
    backend_protocol  = "http"
    backend_port      = 80
  }

  health_check {
    protocol            = "http"
    port                = 80
    path                = "/health"
    check_interval      = 15
    response_timeout    = 5
    unhealthy_threshold = 5
    healthy_threshold   = 5
  }
}