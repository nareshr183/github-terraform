
provider “azurerm” {
feature {}
}

# Create a resource group rg-hub
resource "azurerm_resource_group" "rg" {
  name     = "rg-hub"
  location = "East US"
}
