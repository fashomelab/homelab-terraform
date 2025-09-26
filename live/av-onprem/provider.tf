# live/av-onprem/provider.tf
terraform {
  required_version = ">= 1.13.1"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 5.3.0"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.83.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }
}

provider "vault" {
  skip_child_token = true
}

provider "proxmox" {
  endpoint  = data.vault_kv_secret_v2.proxmox_creds.data["PROXMOX_VIRTUAL_ENVIRONMENT_ENDPOINT"]
  api_token = data.vault_kv_secret_v2.proxmox_creds.data["PROXMOX_API_TOKEN"]
  insecure  = true

  ssh {
    agent       = false
    username    = data.vault_kv_secret_v2.proxmox_creds.data["PROXMOX_USER"]
    private_key = data.vault_kv_secret_v2.ssh_keys.data["ci_cd_private_key"]

    node {
      name    = data.vault_kv_secret_v2.proxmox_nodes.data["node_primary_name"]
      address = data.vault_kv_secret_v2.proxmox_nodes.data["node_primary_address"]
    }

    node {
      name    = data.vault_kv_secret_v2.proxmox_nodes.data["node_secondary_name"]
      address = data.vault_kv_secret_v2.proxmox_nodes.data["node_secondary_address"]
    }
  }
}

provider "azurerm" {
  features {}
}
