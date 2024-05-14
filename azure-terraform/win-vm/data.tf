data "azurerm_resource_group" "rg" {
  name = "s6-rg"
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = "example-vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Retrieve existing Subnet
data "azurerm_subnet" "existing_subnet" {
  name                 = "example-subnet"
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}