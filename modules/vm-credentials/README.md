# Terraform Module: VM Credentials

This Terraform module generates a set of credentials for a new virtual machine. Its sole purpose is to create a strong random password and a new 4096-bit RSA SSH key pair.

Following the Single Responsibility Principle, this module is decoupled from VM creation, allowing for clean and secure credential management. It is designed to be used by the [Project FasHomeLab](https://github.com/fashomelab/corneb) infrastructure.

---
## Usage Example

This module takes no inputs. It is called to generate a new, unique set of credentials for each resource that requires them.

```hcl
module "new_vm_secrets" {
  source = "./modules/vm-credentials"
}

# The password can then be accessed via:
# module.new_vm_secrets.password

# The public key can be accessed via:
# module.new_vm_secrets.public_key_openssh

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_password.vm_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_private_key.vm_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_password"></a> [password](#output\_password) | The generated random password for the VM user. |
| <a name="output_public_key_openssh"></a> [public\_key\_openssh](#output\_public\_key\_openssh) | The generated public key for cloud-init. |
<!-- END_TF_DOCS -->