# live/av-azure/dev/backend.tf

terraform {
  backend "azurerm" {
    resource_group_name  = "azlab-tfstate"               # Name of resource group from bootstrap post-bootstrap
    storage_account_name = "azlabtfstateuks"             # Replace with actual name post-bootstrap
    container_name       = "terradata-apexvirtual-az-dev"  # Replace with actual name post-bootstrap
    key                  = "apexvirtual-az-dev.tfstate"    # Environment-specific key
    use_oidc             = true                             # Add for CI/CD
  }
}