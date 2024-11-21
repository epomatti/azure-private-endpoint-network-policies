variable "subscription_id" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "vm_public_key_path" {
  type = string
}

variable "vm_admin_username" {
  type = string
}

variable "allowed_public_ip_address" {
  type = string
}

variable "mssql_sku_name" {
  type = string
}

variable "mssql_max_size_gb" {
  type = number
}
