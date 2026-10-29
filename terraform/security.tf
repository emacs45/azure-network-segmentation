# Network Security Group for backend subnet
resource "azurerm_network_security_group" "backend" {
  name                = "nsg-backend"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
    name                       = "Allow-Frontend-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "10.10.1.0/24"
    destination_address_prefix = "10.10.2.0/24"
  }

  security_rule {
    name                       = "Deny-Frontend-All"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.10.1.0/24"
    destination_address_prefix = "10.10.2.0/24"
  }

  tags = {
    project    = "azure-network-segmentation"
    managed_by = "terraform"
  }
}

# Associate NSG with backend subnet
resource "azurerm_subnet_network_security_group_association" "backend" {
  subnet_id                 = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.backend.id
}