resource "azurerm_application_security_group" "storage001" {
  name                = "asg-storage001"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_application_security_group" "database" {
  name                = "asg-database"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_application_security_group" "virtual_machine" {
  name                = "asg-virtual-machine"
  location            = var.location
  resource_group_name = var.resource_group_name
}
