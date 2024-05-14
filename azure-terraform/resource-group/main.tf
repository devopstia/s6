resource "azurerm_resource_group" "example" {
  name     = "s6-rg"
  location = var.location
  tags     = var.tags
}