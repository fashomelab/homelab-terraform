# live/av-azure/prod/prod.tfvars
#
# Production environment configuration for ApexVirtual Azure infrastructure
# This showcases enterprise-grade hybrid cloud architecture patterns
#
# Architecture: 3-tier application with private networking, managed database,
# and secure storage - integrated with on-premises Kubernetes clusters
#------------------------------------------------------------------------------------

# --- Naming Convention Components ---
company_abbr = "av"   # ApexVirtual abbreviation
environment  = "prod" # Production environment
region_abbr  = "uks"  # UK South region abbreviation

# Global Settings
location = "uksouth" # Azure UK South region

# Resource Group Settings
resource_group_name = "apexvirtual-resources-prod"

# Private DNS Zone Settings
private_dns_zone_name = "apexvirtual.postgres.database.azure.com"

# VNet Settings
virtual_network_name          = "apexvirtual-vnet-prod"
virtual_network_address_space = ["10.2.0.0/16"] # Prod uses 10.2.x.x (dev uses 10.1.x.x)
subnets = {
  "av-prod-frontend" = {
    address_prefixes  = ["10.2.1.0/24"]
    service_endpoints = ["Microsoft.Storage"]
  },
  "av-prod-backend" = {
    address_prefixes  = ["10.2.2.0/24"]
    service_endpoints = ["Microsoft.Storage"]
  },
  "av-prod-database" = {
    address_prefixes  = ["10.2.3.0/24"]
    service_endpoints = ["Microsoft.Storage"]
    delegation_name   = "Microsoft.DBforPostgreSQL/flexibleServers"
  }
}

# Virtual Machine Settings
vm_size          = "Standard_B2s" # Slightly larger for production
create_public_ip = false          # Production VMs should be private

# Virtual Machine - source image reference
image_publisher = "Canonical"
image_offer     = "0001-com-ubuntu-server-jammy"
image_sku       = "22_04-lts-gen2"
image_version   = "latest"

# Azure Managed Database Settings
db_version                    = 15    # Latest stable PostgreSQL
db_storage_mb                 = 65536 # 64GB for production workloads
public_network_access_enabled = false # Private database access only

# Storage Account Settings
storage_account_name = "avprodstorageuksouth" # Globally unique name
container_names      = ["k8s-backups", "application-data", "disaster-recovery"]

# Common Tags
common_tags = {
  Owner        = "platform-engineering"
  Environment  = "production"
  BusinessUnit = "apexvirtual"
  ManagedBy    = "Terraform"
  Repository   = "github.com/apexvirtual/terraform"
  CostCenter   = "infrastructure"
  Backup       = "enabled"
  Monitoring   = "enabled"
}