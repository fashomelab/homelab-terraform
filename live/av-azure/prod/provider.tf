# live/av-azure/dev/provider.tf

terraform {
  required_version = ">= 1.13.1"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 5.3.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.37.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "vault" {
  skip_child_token = true
}

provider "azurerm" {
  features {}
  use_oidc = true
}
