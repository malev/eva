//Export this cluster's attributes
output "kubeconfig" {
  value = linode_lke_cluster.galileo.kubeconfig
}

output "api_endpoints" {
  value = linode_lke_cluster.galileo.api_endpoints
}

output "status" {
  value = linode_lke_cluster.galileo.status
}

output "id" {
  value = linode_lke_cluster.galileo.id
}

output "pool" {
  value = linode_lke_cluster.galileo.pool
}
