terraform {
  backend "azurerm" {
    storage_account_name = "tfstatejdauxp3gqh"
    container_name       = "tfstatejdauxp3gqh"
    key                  = "win-vm/terraform.tfstate"
    resource_group_name  = "s6-rg-storage-backend"
  }
}
