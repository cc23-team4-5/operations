terraform {
  required_version = "> 1.4.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.55.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.38.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "cc23-team4-5-rsg"
    storage_account_name = "cc23team45tfstatesa"
    container_name       = "terraform-state-files"
    key                  = "cc23-team4-5.tfstate"
  }
}

# Configure the Azure provider
provider "azurerm" {
  features {}
}
