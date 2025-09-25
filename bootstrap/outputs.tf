# bootstrap/outputs.tf

output "storage_account_name" {
  description = "The generated storage account name."
  value       = azurerm_storage_account.bootstrap.name
}

output "container_ids" {
  description = "A map of the created container names to their IDs."
  value       = { for container in azurerm_storage_container.bootstrap_containers : container.name => container.id }
}