# Terraform Module: Azure Resource Group

This Terraform module provisions a standard Azure Resource Group, which acts as a foundational container for other resources.

It is designed to be a reusable component for the [Project FasHomeLab](https://github.com/fashomelab/corneb) infrastructure.

---
## Usage Example

Here is a basic example of how to use this module:

```hcl
module "resourcegroup" {
  source = "./modules/resourcegroup"
  
  resource_group_name = "my-awesome-rg"
  location            = "UK South"

  tags = {
    Environment = "production"
  }
}

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.cloudfas](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location where resources will be created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The name of the environment used for tagging | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_location"></a> [location](#output\_location) | The location of the resource group. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group. |
<!-- END_TF_DOCS -->