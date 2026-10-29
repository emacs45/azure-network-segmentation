# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "vnet-network-segmentation"
  address_space       = ["10.10.0.0/16"]
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  tags = {
    project    = "azure-network-segmentation"
    managed_by = "terraform"
  }
}

# Frontend Subnet
resource "azurerm_subnet" "frontend" {
  name                 = "snet-frontend"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.10.1.0/24"]
}

# Backend Subnet
resource "azurerm_subnet" "backend" {
  name                 = "snet-backend"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.10.2.0/24"]
}