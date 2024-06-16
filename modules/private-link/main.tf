resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = "blob-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = var.vnet_id
  registration_enabled  = true
}

resource "azurerm_private_endpoint" "storage001" {
  name                = "pe-storage001"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id



  private_dns_zone_group {
    name = "storage001-blob-group"

    private_dns_zone_ids = [
      azurerm_private_dns_zone.blob.id
    ]
  }

  private_service_connection {
    name                           = "storage"
    private_connection_resource_id = var.storage001_id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.blob]
}

resource "azurerm_private_endpoint_application_security_group_association" "storage001" {
  private_endpoint_id           = azurerm_private_endpoint.storage001.id
  application_security_group_id = var.storage001_application_security_group_id
}

resource "azurerm_private_endpoint" "storage002" {
  name                = "pe-storage002"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name = "storage002-blob-group"

    private_dns_zone_ids = [
      azurerm_private_dns_zone.blob.id
    ]
  }

  private_service_connection {
    name                           = "storage"
    private_connection_resource_id = var.storage002_id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.blob]
}
