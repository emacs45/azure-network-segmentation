output "resource_group_name" {
  description = "Name of the created resource group"
  value       = data.azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "Azure resource ID of the resource group"
  value       = data.azurerm_resource_group.main.id
}