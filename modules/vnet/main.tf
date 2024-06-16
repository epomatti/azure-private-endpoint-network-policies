### Virtual Network ###
resource "azurerm_virtual_network" "default" {
  name                = "vnet-${var.workload}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

### Subnets ###
resource "azurerm_subnet" "vms" {
  name                            = "virtual-machines"
  resource_group_name             = var.resource_group_name
  virtual_network_name            = azurerm_virtual_network.default.name
  address_prefixes                = ["10.0.20.0/24"]
  default_outbound_access_enabled = true

  # This is already the default; just showing it here for reference
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies             = "Enabled"
}

resource "azurerm_subnet" "pes" {
  name                            = "private-endpoints"
  resource_group_name             = var.resource_group_name
  virtual_network_name            = azurerm_virtual_network.default.name
  address_prefixes                = ["10.0.70.0/24"]
  default_outbound_access_enabled = true

  # This is already the default; just showing it here for reference
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies             = "Enabled"
}
