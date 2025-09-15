# labsterraform/modules/azure-database/main.tf

resource "azurerm_private_dns_zone_virtual_network_link" "main" {
  name                  = "${var.db_name}-dns-link"
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
}

resource "azurerm_postgresql_flexible_server" "clouddb" {
  name                = var.db_name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login    = var.db_admin_login
  administrator_password = var.db_admin_password

  sku_name   = var.sku_name
  version    = var.db_version
  storage_mb = var.db_storage_mb

  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = var.private_dns_zone_id
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags

  # This lifecycle block tells Terraform to ignore changes to the availability zone,
  # preventing it from trying to move the database back after a legitimate failover event.
  lifecycle {
    ignore_changes = [
      zone,
    ]
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.main]
}