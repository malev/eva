resource "vultr_kubernetes" "galileo" {
  region  = var.region
  label   = var.label
  version = "v1.21.7+2"

  node_pools {
    node_quantity = var.node_quantity
    plan          = var.node_plan
    label         = "node"
  }
}

