<<<<<<< HEAD
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

=======
>>>>>>> dbe37b3fe571a150894285cf80cc4ea7b3b976af
terraform {
  backend "azurerm" {

  }
}

<<<<<<< HEAD


# Configure the Microsoft Azure Provider
=======
>>>>>>> dbe37b3fe571a150894285cf80cc4ea7b3b976af
provider "azurerm" {
features {}
}



# Create a resource group rg-hub
resource "azurerm_resource_group" "rg" {
  name     = "rg-hub"
  location = "East US"
}
