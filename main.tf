# main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "gitops_rg" {
  name     = "GitOps-RG"
  location = "East US"

  tags = {
    environment = "production"
    managed-by  = "terraform-gitops"
    demo-by     = "Niraj Kumar"
  }
}