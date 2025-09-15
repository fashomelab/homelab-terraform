# labsterraform/modules/azure-private-dns/main.tf

resource "azurerm_private_dns_zone" "privatednszone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}