data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "s6-key-vault"
  location = var.location
}

resource "azurerm_key_vault" "example" {
  name                        = "s6keyvaul2024"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    # Assign full access permissions to secrets
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Purge",
    ]

    # Assign full access permissions to keys
    key_permissions = [
      "Get",
      "List",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Decrypt",
      "Encrypt",
      "UnwrapKey",
      "WrapKey",
      "Verify",
      "Sign",
      "Purge",
      "Release",
      "Rotate",
      "GetRotationPolicy",
      "SetRotationPolicy",
    ]

    # Assign full access permissions to certificates
    certificate_permissions = [
      "Get",
      "List",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "ManageContacts",
      "ManageIssuers",
      "GetIssuers",
      "ListIssuers",
      "SetIssuers",
      "DeleteIssuers",
      "Purge",
    ]

    # Assign full access permissions to storage
    storage_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Purge",
    ]
  }
}

resource "azurerm_key_vault_secret" "aks_windows_secret" {
  name         = "aks-windows-secret"
  value        = "P@ssw0rd1234!$#"
  key_vault_id = azurerm_key_vault.example.id
}