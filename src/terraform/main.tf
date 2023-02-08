
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

# create virtual network

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-Hub-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  depends_on = [azurerm_resource_group.rg]
}



# create subnet for virtual machines

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
 depends_on = [azurerm_resource_group.rg,azurerm_virtual_network.vnet1 ]
}

# create network security group and added one rule to allow all traffic 

resource "azurerm_network_security_group" "nsg1" {
  name                = "NetworkSecurityGroup1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "nsg_rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [azurerm_resource_group.rg ]
}

# network security group association with subnet

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_association" {

  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
  depends_on = [azurerm_subnet.subnet1,azurerm_network_security_group.nsg1]
}

# create Network interface card

resource "azurerm_network_interface" "nic1" {
  name                = "hub-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [azurerm_subnet.subnet1]
}

# create ubuntu machine 1

resource "azurerm_virtual_machine" "webserver-1" {
  name                  = "webserver-1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic1.id]
  vm_size               = "Standard_B1ms"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
   delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
   delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "webserver-1"
    admin_username = "naresh"
    admin_password = "Saibaba@2834"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  depends_on = [azurerm_network_interface.nic1,azurerm_resource_group.rg]
}
