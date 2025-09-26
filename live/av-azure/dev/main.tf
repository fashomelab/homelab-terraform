# live/av-azure/dev/main.tf
# Main Terraform configuration for the AV Azure Dev environment.
# This file orchestrates the creation of all resources using modules and variables.

locals {
  # Standardize inputs to ensure consistent formatting.
  company_abbr = lower(var.company_abbr)
  environment  = lower(var.environment)
  region       = lower(var.region_abbr)

  # Construct predictable, standardized names for all resources.
  vm_name = "${local.company_abbr}-${local.environment}"                 # e.g., azlab-dev
  db_name = "${local.company_abbr}-${local.environment}-${local.region}" # e.g., azlab-dev-uks
}


# 1. Fetch Secrets from Vault
# ---------------------------
data "vault_kv_secret_v2" "azure_credentials" {
  mount = "kv"
  name  = "azhomelab-dev/azure-credentials"
}

data "vault_kv_secret_v2" "azure_config" {
  mount = "kv"
  name  = "azhomelab-dev/azure-config"
}

data "vault_kv_secret_v2" "ssh_keys" {
  mount = "kv"
  name  = "azhomelab-dev/ssh-keys"
}

# 2. Create the foundational Resource Group
# ---------------------------------------
module "resourcegroup" {
  source              = "../../../modules/resourcegroup"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.common_tags
}

# 3. Private DNS for PaaS Services
# -------------------------------
module "private_dns_zone" {
  source                = "../../../modules/azure-private-dns"
  resource_group_name   = module.resourcegroup.resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  tags                  = var.common_tags
}

# 4. Create the core networking
# -----------------------------
module "networking" {
  source                        = "../../../modules/networking"
  resource_group_name           = module.resourcegroup.resource_group_name
  location                      = module.resourcegroup.location
  virtual_network_name          = var.virtual_network_name
  virtual_network_address_space = var.virtual_network_address_space
  subnets                       = var.subnets
  tags                          = var.common_tags
}

# 5. Create a Linux Virtual Machine in the frontend subnet
# -------------------------------------------------------
module "web_vm" {
  source               = "../../../modules/azure-vm-linux"
  vm_name              = "${local.vm_name}-web-vm"
  resource_group_name  = module.resourcegroup.resource_group_name
  location             = module.resourcegroup.location
  vm_size              = var.vm_size
  image_publisher      = var.image_publisher
  image_offer          = var.image_offer
  image_sku            = var.image_sku
  image_version        = var.image_version
  subnet_id            = module.networking.subnet_ids_by_name["azhomelab-frontend"]
  admin_username       = data.vault_kv_secret_v2.azure_credentials.data["admin_username"]
  admin_ssh_key_public = data.vault_kv_secret_v2.ssh_keys.data["user_public_key"]
  create_public_ip     = var.create_public_ip
  tags                 = var.common_tags
}

# 6. Create a Linux Virtual Machine in the backend subnet (App Tier)
# ----------------------------------------------------------------
module "app_vm" {
  source               = "../../../modules/azure-vm-linux"
  vm_name              = "${local.db_name}-app-vm"
  resource_group_name  = module.resourcegroup.resource_group_name
  location             = module.resourcegroup.location
  vm_size              = var.vm_size
  image_publisher      = var.image_publisher
  image_offer          = var.image_offer
  image_sku            = var.image_sku
  image_version        = var.image_version
  subnet_id            = module.networking.subnet_ids_by_name["azhomelab-backend"]
  admin_username       = data.vault_kv_secret_v2.azure_credentials.data["admin_username"]
  admin_ssh_key_public = data.vault_kv_secret_v2.ssh_keys.data["user_public_key"]
  create_public_ip     = false
  tags                 = var.common_tags
}

# 7. Create the managed PostgreSQL database in the backend subnet (Data Tier)
# -------------------------------------------------------------------------
module "database" {
  source                        = "../../../modules/azure-database"
  db_name                       = "${local.vm_name}-psqlflexibles-db"
  resource_group_name           = module.resourcegroup.resource_group_name
  location                      = module.resourcegroup.location
  db_version                    = var.db_version
  db_storage_mb                 = var.db_storage_mb
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.common_tags
  subnet_id                     = module.networking.subnet_ids_by_name["database-subnet"]
  private_dns_zone_name         = var.private_dns_zone_name
  private_dns_zone_id           = module.private_dns_zone.id
  virtual_network_id            = module.networking.virtual_network_id
  db_admin_login                = data.vault_kv_secret_v2.azure_credentials.data["db_admin_login"]
  db_admin_password             = data.vault_kv_secret_v2.azure_credentials.data["db_admin_password"]
}

# 8. Create the storage account
# -----------------------------
module "storage" {
  source                 = "../../../modules/storage"
  resource_group_name    = module.resourcegroup.resource_group_name
  location               = module.resourcegroup.location
  storage_account_name   = var.storage_account_name
  network_rules_ip_rules = [data.vault_kv_secret_v2.azure_config.data["network_rules_ip_rules"]]
  container_names        = var.container_names
  virtual_network_subnet_ids = [
    module.networking.subnet_ids_by_name["azhomelab-frontend"],
    module.networking.subnet_ids_by_name["azhomelab-backend"]
  ]
  tags = var.common_tags
}