terraform {
  backend "azurerm" {
    resource_group_name  = "rg-dnlh-12mar-dev"
    storage_account_name = "sttfstatedhls"
    container_name       = "terraformstate"
    key                  = "terraformstate.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "rg-dnlh-12mar-dev" {
  name     = "rg-dnlh-12mar-dev"
  location = "eastus"
}

#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-dnlh-12mar-dev"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.rg-dnlh-12mar-dev.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.rg-dnlh-12mar-dev.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}
  
