resource "azurerm_application_security_group" "storage001" {
  name                = "asg-storage001"
  location            = var.location
  resource_group_name = var.resource_group_name
}
