# labsterraform/modules/azure-database/outputs.tf

output "id" {
  description = "The ID of the created PostgreSQL flexible server."
  value       = azurerm_postgresql_flexible_server.clouddb.id
}

output "fqdn" {
  description = "The fully qualified doclouddb name (FQDN) of the PostgreSQL flexible server. This is the address your application will use to connect."
  value       = azurerm_postgresql_flexible_server.clouddb.fqdn
  sensitive   = true # The FQDN can be considered sensitive information.
}