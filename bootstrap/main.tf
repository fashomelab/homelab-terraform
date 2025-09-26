# bootstrap/main.tf
#
# This configuration bootstraps the foundational Azure infrastructure required for
# the Terraform remote backend. It creates a Resource Group and a globally unique
# Storage Account to securely store all Terraform state files for the homelab.

# Define all names and naming conventions in one place for consistency.
locals {
  # Standardize inputs to ensure consistent formatting.
  company_abbr = lower(var.company_abbr)
  region       = lower(var.region_abbr)

  # Construct predictable, standardized names for all resources.
  rg_name      = "${local.company_abbr}-tfstate"
  storage_name = "${local.company_abbr}tfstate${local.region}"
}

# Provisions the main Resource Group.
resource "azurerm_resource_group" "bootstrap" {
  name     = local.rg_name
  location = var.location
  tags     = var.common_tags
}

# Provisions the globally unique Storage Account for Terraform state.
resource "azurerm_storage_account" "bootstrap" {
  name                            = local.storage_name
  resource_group_name             = azurerm_resource_group.bootstrap.name
  location                        = azurerm_resource_group.bootstrap.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  allowed_copy_scope              = var.allowed_copy_scope

  network_rules {
    default_action = "Deny"
    ip_rules       = var.network_rules_ip_rules
  }

  tags = var.common_tags
}

# Dynamically creates a container for each name in the `var.container_names` list.
resource "azurerm_storage_container" "bootstrap_containers" {
  for_each = toset(var.container_names)

  # Appends the environment name to each container for clarity (e.g., "terradata-azure-dev").
  name                  = each.key
  storage_account_id    = azurerm_storage_account.bootstrap.id
  container_access_type = var.container_access_type
}