output "ssh_command" {
  value = "ssh azureuser@${module.vm001.public_ip_address}"
}

output "storage001_name" {
  value = module.storage_001.storage_account_name
}

output "storage002_name" {
  value = module.storage_002.storage_account_name
}
