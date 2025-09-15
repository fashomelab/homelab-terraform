# Terraform Module: Proxmox QEMU Virtual Machine

This Terraform module provisions a standardized QEMU virtual machine in a Proxmox VE cluster.

It is designed to be a reusable and configurable component for creating VMs from a cloud-init ready image. The module handles the configuration of CPU, memory, disk, and network, and securely injects user credentials on first boot. It is a core component of the [Project FasHomeLab](https://github.com/fashomelab/corneb) infrastructure.

---
## Usage Example

Here is a basic example of how to use this module to create a new VM. Note that credential variables are typically passed in from a dedicated credentials module.

```hcl
module "new_server" {
  source   = "./modules/vmprox"
  
  # VM Configuration
  vm_name      = "my-new-server"
  vm_id        = 1001
  node_name    = "proxmox-node-1"
  core_count   = 2
  memory       = 2048
  datastore    = "local-lvm"
  guestagent   = "true"
  bridge       = "vmbr0"
  vlanid       = 10
  image_file_id = "local:iso/ubuntu-22.04-cloudimg.qcow2"
  
  # Credentials & User Config
  proxmoxuser            = "terraform-user"
  vm_password              = module.new_vm_secrets.password
  cloud_init_public_keys = [
    module.new_vm_secrets.public_key_openssh,
    var.admin_user_public_key
  ]

  # Provider Credentials
  virtual_environment_endpoint = var.proxmox_endpoint
  api_token                    = var.proxmox_api_token

  tags = ["webserver", "ubuntu"]
}

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.83.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.83.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_vm.ubuntu_vm](https://registry.terraform.io/providers/bpg/proxmox/0.83.0/docs/resources/virtual_environment_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | API token used for authenticating to proxmox node | `string` | n/a | yes |
| <a name="input_bridge"></a> [bridge](#input\_bridge) | proxmox vmbrX to use | `string` | n/a | yes |
| <a name="input_cloud_init_public_keys"></a> [cloud\_init\_public\_keys](#input\_cloud\_init\_public\_keys) | A list of SSH public keys to inject via cloud-init. | `list(string)` | n/a | yes |
| <a name="input_core_count"></a> [core\_count](#input\_core\_count) | Number of cores to assign to VM | `number` | n/a | yes |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | Where to store datadisk - local-lvm or vm-disks | `string` | n/a | yes |
| <a name="input_guestagent"></a> [guestagent](#input\_guestagent) | Enable guest agent only after creation | `string` | n/a | yes |
| <a name="input_image_file_id"></a> [image\_file\_id](#input\_image\_file\_id) | ID of the downloaded image file to use for VM | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of RAM to assign to VM | `number` | n/a | yes |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Name of proxmox host to deploy to | `string` | n/a | yes |
| <a name="input_proxmoxuser"></a> [proxmoxuser](#input\_proxmoxuser) | Proxmox user for SSH connections. | `string` | `"fasautomation"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the Proxmox VM | `list(string)` | <pre>[<br/>  "terraform"<br/>]</pre> | no |
| <a name="input_virtual_environment_endpoint"></a> [virtual\_environment\_endpoint](#input\_virtual\_environment\_endpoint) | Endpoint of proxmox nodes (URL - https://ipaddress:8006/) | `string` | n/a | yes |
| <a name="input_vlanid"></a> [vlanid](#input\_vlanid) | vlan id to use | `number` | n/a | yes |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | ID to use for the VM - these need to be globally unique within your promox cluster/node | `number` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name of the VM | `string` | n/a | yes |
| <a name="input_vm_password"></a> [vm\_password](#input\_vm\_password) | The initial password for the VM user account. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->