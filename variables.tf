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

variable "mssql_sku_name" {
  type    = string
  default = "Basic"
}

variable "mssql_max_size_gb" {
  type    = number
  default = 2
}
