
# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "=3.0.0"
#     }
#   }

#  backend "azurerm" {
#     resource_group_name  = "rg-tf"
#     storage_account_name = "tfstfjan2023acc"
#     container_name       = "tfstatefile"
#     key                  = "dev.terraform.tfstate"
#   }
# }

terraform {
  backend "azurerm" {

  }
}



# Configure the Microsoft Azure Provider
provider "azurerm" {
features {}
}



# Create a resource group rg-hub
resource "azurerm_resource_group" "rg" {
  name     = "rg-hub"
  location = "East US"
}
