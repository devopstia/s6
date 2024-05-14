resource "azurerm_resource_group" "example" {
  name     = "s6-rg-storage-backend"
  location = var.location
  tags     = var.tags
}

resource "random_string" "storage_account_name" {
  length  = 10
  special = false
  lower   = true
  upper   = false
}

resource "azurerm_storage_account" "example" {
  name                     = "tfstate${random_string.storage_account_name.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "example" {
  name                  = "tfstate${random_string.storage_account_name.result}"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}
