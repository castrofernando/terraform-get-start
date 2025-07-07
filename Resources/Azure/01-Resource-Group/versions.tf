terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  backend "azurerm" {
      resource_group_name  = "tfstate"
      storage_account_name = "tfstate0fe2z"
      container_name       = "tfstate"
      key                  = "01-ResourceGroup/terraform.tfstate"
  }
  required_version = ">= 1.1.0"
}