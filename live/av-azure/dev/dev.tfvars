# live/av-azure/dev/dev.tfvars
#
# Development environment configuration for ApexVirtual Azure infrastructure
# This showcases enterprise-grade hybrid cloud architecture patterns
#
# Architecture: 3-tier application with private networking, managed database,
# and secure storage - integrated with on-premises Kubernetes clusters
#------------------------------------------------------------------------------------

# --- Naming Convention Components ---
company_abbr = "av"  # ApexVirtual abbreviation
environment  = "dev" # Development environment
region_abbr  = "uks" # UK South region abbreviation

# Global Settings
location = "uksouth" # Azure UK South region

# Resource Group Settings
resource_group_name = "apexvirtual-resources-dev"

# Private DNS Zone Settings
private_dns_zone_name = "apexvirtual.postgres.database.azure.com"

# VNet Settings
virtual_network_name          = "apexvirtual-vnet-dev"
virtual_network_address_space = ["10.1.0.0/16"] # dev uses 10.1.x.x (dev uses 10.1.x.x)
subnets = {
  "av-dev-frontend" = {
    address_prefixes  = ["10.1.1.0/24"]
    service_endpoints = ["Microsoft.Storage"]
  },
  "av-dev-backend" = {
    address_prefixes  = ["10.1.2.0/24"]
    service_endpoints = ["Microsoft.Storage"]
  },
  "av-dev-database" = {
    address_prefixes  = ["10.1.3.0/24"]
    service_endpoints = ["Microsoft.Storage"]
    delegation_name   = "Microsoft.DBforPostgreSQL/flexibleServers"
  }
}

# Virtual Machine Settings
vm_size          = "Standard_B1s" # Slightly smaller for development
create_public_ip = true           # Development VMs should be public

# Virtual Machine - source image reference
image_publisher = "Canonical"
image_offer     = "0001-com-ubuntu-server-jammy"
image_sku       = "22_04-lts-gen2"
image_version   = "latest"

# Azure Managed Database Settings
db_version                    = 15    # Latest stable PostgreSQL
db_storage_mb                 = 32768 # 32GB for development workloads
public_network_access_enabled = false # Private database access only

# Storage Account Settings
storage_account_name = "avdevstorageuksouth" # Globally unique name
container_names      = ["k8s-backups", "application-data", "disaster-recovery"]

# Common Tags
common_tags = {
  Owner        = "platform-engineering"
  Environment  = "development"
  BusinessUnit = "apexvirtual"
  ManagedBy    = "Terraform"
  Repository   = "github.com/apexvirtual/terraform"
  CostCenter   = "infrastructure"
  Backup       = "enabled"
  Monitoring   = "enabled"
}
