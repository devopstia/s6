terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "tfstatejdauxp3gqh"
    container_name       = "tfstatejdauxp3gqh"
    key                  = "azure-key-vault/terraform.tfstate"
    resource_group_name  = "s6-rg-storage-backend"
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}