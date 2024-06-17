output "storage001_asg_id" {
  value = azurerm_application_security_group.storage001.id
}

output "database_asg_id" {
  value = azurerm_application_security_group.database.id
}
