output "container_registry_name" {
  value = azurerm_container_registry.acr.name
}

output "container_registry_id" {
  value = azurerm_container_registry.acr.id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}