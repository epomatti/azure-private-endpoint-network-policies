locals {
  file = "foo.txt"
}

resource "azurerm_storage_account" "default" {
  name                          = "st${var.workload}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  account_kind                  = "StorageV2"
  https_traffic_only_enabled    = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = true

  network_rules {
    default_action = "Deny"
    ip_rules       = [var.allowed_public_ip_address]
    # virtual_network_subnet_ids = [var.subnet_id]
    bypass = ["AzureServices"]
  }
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_id    = azurerm_storage_account.default.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "foo" {
  name                   = local.file
  storage_account_name   = azurerm_storage_account.default.name
  storage_container_name = azurerm_storage_container.data.name
  type                   = "Block"
  source                 = "${path.module}/files/${local.file}"
}
