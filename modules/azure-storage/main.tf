# /labsterraform/modules/storage/main.tf

resource "azurerm_storage_account" "cloudstorageaccount" {
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  allow_nested_items_to_be_public = false
  allowed_copy_scope              = var.allowed_copy_scope

  network_rules {
    default_action             = "Deny"
    ip_rules                   = var.network_rules_ip_rules
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }

  tags = var.tags
}

resource "azurerm_storage_container" "containername" {
  for_each           = toset(var.container_names)
  name               = each.key
  storage_account_id = azurerm_storage_account.cloudstorageaccount.id
}