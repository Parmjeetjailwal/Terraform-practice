# Terraform Block
terraform {
  required_version = ">= 0.15"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "1.44.0"
      #version = ">= 2.0" 
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

# Resource-1:- Create a resource group in EastUS region
resource "azurerm_resource_group" "myrg" {
  name     = "myrg-1"
  location = "East US"
}

# Resource-2: Random String 
resource "random_string" "myrandom" {
  length  = 8
  upper   = false
  special = false
}

# Resource-3: Azure Storage Account 
resource "azurerm_storage_account" "mysa" {
  name                      = "mysa${random_string.myrandom.id}"
  resource_group_name       = azurerm_resource_group.myrg.name
  location                  = azurerm_resource_group.myrg.location
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  account_encryption_source = "Microsoft.Storage"
}
