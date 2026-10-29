locals {
  vm_size = "Standard_B1s"
  vm_user = "azureuser"

  vms = {
    frontend = {
      subnet_id = azurerm_subnet.frontend.id
    }
    backend = {
      subnet_id = azurerm_subnet.backend.id
    }
  }
}

resource "azurerm_network_interface" "vm" {
  for_each = local.vms

  name                = "nic-${each.key}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = local.vms

  name                = "vm-${each.key}"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  size                = local.vm_size

  admin_username                  = local.vm_user
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.vm[each.key].id
  ]

  admin_ssh_key {
    username   = local.vm_user
    public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  custom_data = each.key == "backend" ? base64encode(
    file("${path.module}/cloud-init-backend.yaml")
  ) : null

  tags = {
    project    = "azure-network-segmentation"
    managed_by = "terraform"
    role       = each.key
  }
}