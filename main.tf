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
  # FIX: Add the features block to control provider behavior.
  features {
    resource_group {
      # This setting tells Terraform to skip its safety check and allow
      # the deletion of a resource group even if it contains resources
      # managed by this Terraform configuration.
      prevent_deletion_if_contains_resources = false
    }
  }
}
# --- Resource Group ---
# Defines the resource group where all our resources will live.
resource "azurerm_resource_group" "gitops_rg1" {
  name     = "GitOps-RG1"
  location = "Central US"

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
  location                 = "Central US"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "production"
    managed-by  = "terraform-gitops"
    cost-center = "devops"
  }
}