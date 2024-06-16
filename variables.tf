variable "location" {
  type    = string
  default = "eastus2"
}

variable "vm_size" {
  type    = string
  default = "Standard_B2pls_v2"
}

variable "allowed_public_ip_address" {
  type = string
}
