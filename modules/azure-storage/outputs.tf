# /labsterraform/modules/storage/outputs.tf

output "storage_account_id" {
  description = "The ID of the created storage account."
  value       = azurerm_storage_account.cloudstorageaccount.id
}

output "storage_account_name" {
  description = "The generated storage account name."
  value       = azurerm_storage_account.cloudstorageaccount.name
}

output "container_ids" {
  description = "A map of the created container names to their IDs."
  value       = { for container in azurerm_storage_container.containername : container.name => container.id }
}