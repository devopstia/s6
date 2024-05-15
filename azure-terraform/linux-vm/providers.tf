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
    key                  = "linux-vm/terraform.tfstate"
    resource_group_name  = "s6-rg-storage-backend"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}


