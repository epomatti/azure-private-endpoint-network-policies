resource "azurerm_network_security_group" "vm001" {
  name                = "nsg-vm001"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface_security_group_association" "vm001" {
  network_interface_id      = var.vm001_network_interface_id
  network_security_group_id = azurerm_network_security_group.vm001.id
}

resource "azurerm_network_security_rule" "inbound_allow_ssh" {
  name                        = "AllowSSH"
  priority                    = 500
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${var.allowed_public_ip_address}/32"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vm001.name
}

resource "azurerm_network_security_rule" "outbound_allow_asg" {
  name                                       = "AllowASGStoragePrivateEndpoints"
  priority                                   = 400
  direction                                  = "Outbound"
  access                                     = "Allow"
  protocol                                   = "*"
  source_port_range                          = "*"
  destination_port_ranges                    = ["80", "443"]
  source_address_prefix                      = "*"
  destination_application_security_group_ids = var.asg_private_endpoints_ids
  resource_group_name                        = var.resource_group_name
  network_security_group_name                = azurerm_network_security_group.vm001.name
}

resource "azurerm_network_security_rule" "outbound_allow_internet" {
  name                        = "AllowInternet"
  priority                    = 500
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vm001.name
}

resource "azurerm_network_security_rule" "outbound_deny_all" {
  name                        = "DenyAll"
  priority                    = 1000
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vm001.name
}
