# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-hub"
  location = "East US"
}
