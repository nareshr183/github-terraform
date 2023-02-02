terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
}

#provider "azuread" {
 # tenant_id = "08f4d6fc-47d1-4a61-b499-f653c720883c"
#}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "3b8eb645-c813-405f-aa51-ab836672cf35"
  client_id       = "62b4e4fc-ae34-4331-a2ed-fbff8d7b5574"
  client_secret   = "_G18Q~v239KRaIQSZJElY_zjpFVH6D4iC.3_ram-"
  tenant_id = "08f4d6fc-47d1-4a61-b499-f653c720883c"
}
# Create a resource group rg-hub
resource "azurerm_resource_group" "rg" {
  name     = "rg-hub"
  location = "East US"
}
