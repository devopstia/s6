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


# Retrieve the Key Vault details
data "azurerm_key_vault" "example" {
  name                = "s6keyvaul2024"
  resource_group_name = "s6-key-vault"
}

# Retrieve the secret from the Key Vault
data "azurerm_key_vault_secret" "example" {
  name         = "aks-windows-secret"
  key_vault_id = data.azurerm_key_vault.example.id
}

# Output the secret value (for demonstration purposes; in practice, handle securely)
output "secret_value" {
  value     = data.azurerm_key_vault_secret.example.value
  sensitive = true
}