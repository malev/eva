variable "api_key" {
  description = "Your Vultr API personal token. (required)"
}

variable "region" {
  description = "The region your VKE cluster will be deployed in. Currently, supported values are ewr and lax"
  default     = "lax"
}

variable "label" {
  description = "Your SSH public key"
  default     = "galileo"
}

variable "node_quantity" {
  description = "(Required) The number of nodes in this node pool."
  default     = 3
}

variable "node_plan" {
  description = "(Required) The plan to be used in this node pool"
  default     = "vc2-1c-2gb"
}
