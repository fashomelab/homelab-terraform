# /labsterraform/modules/networking/outputs.tf

output "virtual_network_id" {
  description = "The ID of the created virtual network."
  value       = azurerm_virtual_network.cloudnet.id
}

output "subnet_ids_by_name" {
  description = "A map of the created subnet names to their IDs."
  value       = { for subnet in azurerm_virtual_network.cloudnet.subnet : subnet.name => subnet.id }
}