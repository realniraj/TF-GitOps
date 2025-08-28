# backend.tf

terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate21835" # Replace with your unique name
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate" # The name of the state file
  }
}