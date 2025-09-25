# labsterraform/environments/azhomelab/prod/provider.tf
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
  address = "https://vault.local.doubledawnfas.com"
}

provider "azurerm" {
  features {}
  use_oidc = true
}
