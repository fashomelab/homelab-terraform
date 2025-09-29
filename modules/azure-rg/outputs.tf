# labsterraform/modules/resourcegroup/outputs.tf

output "resource_group_name" {
  description = "The name of the resource group."
  value       = azurerm_resource_group.cloudfas.name
}

output "location" {
  description = "The location of the resource group."
  value       = azurerm_resource_group.cloudfas.location
}