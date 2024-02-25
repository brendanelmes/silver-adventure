resource "random_pet" "rg_name" {
  prefix = "rg"
}

resource "azurerm_resource_group" "rg" {
  location = "uksouth"
  name     = random_pet.rg_name.id
}

resource "random_string" "rg_name" {
  length = 16
  special = false
  upper = false
}

resource "azurerm_container_registry" "acr" {
  name     = random_string.rg_name.id
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
}