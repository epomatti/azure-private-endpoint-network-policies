output "ssh_command" {
  value = "ssh azureuser@${module.vm001.public_ip_address}"
}
