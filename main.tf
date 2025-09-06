terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.1"
    }
  }
}

provider "azurerm" {
  features {}
}

# --- Resource Group ---
# Defines the resource group where all our resources will live.
resource "azurerm_resource_group" "gitops_rg1" {
  name     = "GitOps-RG1"
  location = "East US"

  tags = {
    environment = "production"
    managed-by  = "terraform-gitops"
    cost-center = "devops"
  }
}

# --- Random String for Storage Account Name ---
# Creates a random 8-character string to ensure the storage account name is globally unique.
resource "random_string" "sa_suffix" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}

# --- Storage Account ---
# Creates a standard, locally-redundant storage account inside the resource group.
resource "azurerm_storage_account" "gitops_sa" {
  name                     = "gitopsstorage${random_string.sa_suffix.result}"
  resource_group_name      = azurerm_resource_group.gitops_rg1.name
  location                 = azurerm_resource_group.gitops_rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "production"
    managed-by  = "terraform-gitops"
    cost-center = "devops"
  }
}