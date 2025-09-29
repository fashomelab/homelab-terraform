# labsterraform/modules/vmprox/provider.tf
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.83.0"
    }
  }
}
