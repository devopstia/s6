resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.10.0.0/16"]
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.10.1.0/24"]
}