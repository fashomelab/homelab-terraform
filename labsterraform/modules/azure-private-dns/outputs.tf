# labsterraform/modules/azure-private-dns/outputs.tf

output "id" {
  description = "The ID of the created Private DNS Zone."
  value       = azurerm_private_dns_zone.privatednszone.id
}