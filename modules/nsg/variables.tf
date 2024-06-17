variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "allowed_public_ip_address" {
  type = string
}

variable "vm001_network_interface_id" {
  type = string
}

variable "asg_storage_private_endpoints_ids" {
  type = list(string)
}

variable "asg_database_private_endpoints_ids" {
  type = list(string)
}

variable "asg_virtual_machine_ids" {
  type = list(string)
}
