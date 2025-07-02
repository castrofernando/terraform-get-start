provider "azurerm" {
  features {
  }
  subscription_id = var.subscription_id
}

locals {
  #look up will retrieve a single element from map. So use it to set our region based on workspace
  region = lookup(var.region_environment, terraform.workspace)
}

resource "azurerm_resource_group" "rg" {
  name     = "MyResourceGroup_${terraform.workspace}"
  location = local.region
}