# github-terraform

azure devops using pipelines use the below format beacuse at classic editor we are declaring all the background client id, secret id 

terraform {
  backend "azurerm" {

  }
}

provider "azurerm" {
features {}
}



# Create a resource group rg-hub
resource "azurerm_resource_group" "rg" {
  name     = "rg-hub"
  location = "East US"
}