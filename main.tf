terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.108.0"
    }
  }
}

resource "random_string" "workload" {
  length  = 3
  special = false
  upper   = false
}

locals {
  company           = "contoso"
  workload          = "${local.company}-${random_string.workload.result}"
  workload_alphanum = "${local.company}${random_string.workload.result}"
}

resource "azurerm_resource_group" "default" {
  name     = "rg-${local.workload}"
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
}

module "vm001" {
  source              = "./modules/vm"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  subnet_id           = module.vnet.vms_subnet_id
  size                = var.vm_size
}

module "iam" {
  source             = "./modules/iam"
  vm001_principal_id = module.vm001.principal_id
  storage001_id      = module.storage_001.storage_account_id
  storage002_id      = module.storage_002.storage_account_id
}

### Network Security ###
module "asg" {
  source              = "./modules/asg"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
}

module "nsg" {
  source                     = "./modules/nsg"
  resource_group_name        = azurerm_resource_group.default.name
  location                   = azurerm_resource_group.default.location
  allowed_public_ip_address  = var.allowed_public_ip_address
  vm001_network_interface_id = module.vm001.network_interface_id
  asg_private_endpoints_ids  = [module.asg.id]
}

### Storage ###
module "storage_001" {
  source                    = "./common/storage"
  resource_group_name       = azurerm_resource_group.default.name
  location                  = azurerm_resource_group.default.location
  workload                  = "${local.workload_alphanum}001"
  allowed_public_ip_address = var.allowed_public_ip_address
}

module "storage_002" {
  source                    = "./common/storage"
  resource_group_name       = azurerm_resource_group.default.name
  location                  = azurerm_resource_group.default.location
  workload                  = "${local.workload_alphanum}002"
  allowed_public_ip_address = var.allowed_public_ip_address
}

### Private Link ###
# module "privatelink" {
#   source              = "./modules/private-link"
#   location            = azurerm_resource_group.default.location
#   resource_group_name = azurerm_resource_group.default.name
#   vnet_id             = module.vnet.vnet_id
#   subnet_id           = module.vnet.vms_subnet_id
#   storage001_id       = module.storage_001.storage_account_id
#   storage002_id       = module.storage_002.storage_account_id

#   storage001_application_security_group_id = module.asg.id
# }
