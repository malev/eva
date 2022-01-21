output "ip" {
  value = vultr_instance.eva.main_ip
}

output "fwg_id" {
  value = vultr_firewall_group.fwg.id
}
