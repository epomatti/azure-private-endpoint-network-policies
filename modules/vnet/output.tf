output "vnet_id" {
  value = azurerm_virtual_network.default.id
}

output "vms_subnet_id" {
  value = azurerm_subnet.vms.id
}

output "pes_subnet_id" {
  value = azurerm_subnet.pes.id
}
