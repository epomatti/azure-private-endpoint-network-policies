output "vm_id" {
  value = azurerm_linux_virtual_machine.default.id
}

output "network_interface_id" {
  value = azurerm_network_interface.default.id
}

output "principal_id" {
  value = azurerm_linux_virtual_machine.default.identity[0].principal_id
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.default.public_ip_address
}
