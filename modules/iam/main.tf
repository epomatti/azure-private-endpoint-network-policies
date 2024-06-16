resource "azurerm_role_assignment" "storage001" {
  scope                = var.storage001_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.vm001_principal_id
}

resource "azurerm_role_assignment" "storage002" {
  scope                = var.storage002_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.vm001_principal_id
}
