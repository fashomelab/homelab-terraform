# /labsterraform/environments/azhomelab/prod/backend.tf

terraform {
  backend "azurerm" {
    resource_group_name  = "azlab-tfstate"               # Name of resource group from bootstrap post-bootstrap
    storage_account_name = "azlabtfstateuks"             # Replace with actual name post-bootstrap
    container_name       = "terradata-azure-prod"        # Replace with actual name post-bootstrap
    key                  = "azlabprod.terraform.tfstate" # Environment-specific key
    use_oidc             = true                          # Add for CI/CD
  }
}