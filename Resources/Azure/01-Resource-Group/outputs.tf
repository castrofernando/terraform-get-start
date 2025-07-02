output "resource_group" {
  value = {
    id = azurerm_resource_group.rg.id
    location = azurerm_resource_group.rg.location
    name = azurerm_resource_group.rg.name
  }
  description = "Describe resource group created"
}