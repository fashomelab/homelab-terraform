# Description: Main Terraform configuration file for deploying Proxmox VMs
#  using data from a YAML file and secrets from HashiCorp Vault.

# 1. Fetch all required secrets from HashiCorp Vault.
# ----------------------------------------------------
data "vault_kv_secret_v2" "proxmox_creds" {
  mount = "kv"
  name  = "apexvirtual/proxmox-credentials"
}

data "vault_kv_secret_v2" "proxmox_nodes" {
  mount = "kv"
  name  = "apexvirtual/proxmox-config"
}

data "vault_kv_secret_v2" "ssh_keys" {
  mount = "kv"
  name  = "apexvirtual/ssh-keys"
}

data "vault_kv_secret_v2" "common_tags" {
  mount = "kv"
  name  = "apexvirtual/terraform-config/common-tags"
}

# 2. Load the VM definitions from the local YAML file.
# ----------------------------------------------------
locals {
  vms = yamldecode(file("${path.module}/vms.yaml"))
}

# 3. Generate unique credentials for EACH VM in the YAML file.
# -----------------------------------------------------------
module "vm_credentials" {
  for_each = local.vms
  source   = "../../modules/vm-credentials"
}

# 4. Create the Proxmox VMs by looping over the YAML data.
# ---------------------------------------------------------
module "vmprox" {
  for_each = local.vms
  source   = "../../modules/vmprox"
  providers = {
    proxmox = proxmox
  }

  # Values from vm.yaml file
  vm_name    = each.key
  vm_id      = each.value.vm_id
  node_name  = each.value.node_name
  core_count = each.value.core_count
  memory     = each.value.memory
  datastore  = each.value.datastore
  guestagent = each.value.guestagent
  bridge     = each.value.bridge
  vlanid     = each.value.vlanid
  tags       = sort(concat(jsondecode(data.vault_kv_secret_v2.common_tags.data["common_tags"]), try(each.value.tags, [])))

  # Values from Vault data sources
  virtual_environment_endpoint = data.vault_kv_secret_v2.proxmox_creds.data["PROXMOX_VIRTUAL_ENVIRONMENT_ENDPOINT"]
  api_token                    = data.vault_kv_secret_v2.proxmox_creds.data["PROXMOX_API_TOKEN"]
  proxmoxuser                  = data.vault_kv_secret_v2.proxmox_creds.data["PROXMOX_USER"]
  image_file_id                = proxmox_virtual_environment_download_file.focal_server_cloud_img.id

  # Values passed from vm-credentials module and Vault
  vm_password = module.vm_credentials[each.key].password
  cloud_init_public_keys = [
    module.vm_credentials[each.key].public_key_openssh,
    data.vault_kv_secret_v2.ssh_keys.data["ci_cd_public_key"],
    data.vault_kv_secret_v2.ssh_keys.data["user_public_key"],
  ]
}

# 5. Download the cloud image (run only on the primary node).
# -----------------------------------------------------------
resource "proxmox_virtual_environment_download_file" "focal_server_cloud_img" {
  provider            = proxmox
  content_type        = "iso"
  datastore_id        = "local"
  node_name           = data.vault_kv_secret_v2.proxmox_nodes.data["node_primary_name"]
  url                 = "http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
  overwrite_unmanaged = false

  lifecycle {
    prevent_destroy = true
  }
}