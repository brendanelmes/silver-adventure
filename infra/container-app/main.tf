resource "random_pet" "rg_name" {
  prefix = "rg"
}

resource "azurerm_resource_group" "rg" {
  location = "uksouth"
  name     = random_pet.rg_name.id
}

resource "azurerm_container_app_environment" "env" {
  name                       = "my-env-234"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
}

resource "azurerm_container_app" "app" {
  name                         = "example-app"
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"

  template {
    container {
      name   = "flaskapp"
      image  = "mcr.microsoft.com/azuredocs/aci-helloworld"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}