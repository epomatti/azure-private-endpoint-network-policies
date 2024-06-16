locals {
  username = "azureuser"
}

resource "azurerm_network_interface" "default" {
  name                = "nic-${var.workload}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_linux_virtual_machine" "default" {
  name                  = "vm-${var.workload}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = local.username
  admin_password        = "P@ssw0rd.123"
  network_interface_ids = [azurerm_network_interface.default.id]
  user_data             = filebase64("${path.module}/userdata/ubuntu.sh")

  identity {
    type = "SystemAssigned"
  }

  admin_ssh_key {
    username   = local.username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "osdisk-linux-${var.workload}"
    caching              = "ReadOnly"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-arm64"
    version   = "latest"
  }
}
