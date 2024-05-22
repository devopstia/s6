## get secret from azure key vault
```
secret_value=$(az keyvault secret show --name MySecret --vault-name myKeyVault --query value -o tsv)
echo $secret_value

secret_value=$(az keyvault secret show --name aks-windows-secret --vault-name s6keyvaul2024 --query value -o tsv)
echo $secret_value



# Retrieve the Key Vault details
data "azurerm_key_vault" "example" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

# Retrieve the secret from the Key Vault
data "azurerm_key_vault_secret" "example" {
  name         = var.secret_name
  key_vault_id = data.azurerm_key_vault.example.id
}

# Output the secret value (for demonstration purposes; in practice, handle securely)
output "secret_value" {
  value = data.azurerm_key_vault_secret.example.value
  sensitive = true
}
```