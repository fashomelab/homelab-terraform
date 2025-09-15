# Terraform Module: Azure Virtual Network

This Terraform module provisions a standard Azure Virtual Network (VNet) with two subnets (typically for frontend and backend workloads).

It is designed to be a reusable component for the [Project FasHomeLab](https://github.com/fashomelab/corneb) infrastructure.

---
## Usage Example

Here is a basic example of how to use this module:

```hcl
module "networking" {
  source                        = "./modules/networking"
  
  resource_group_name           = "my-resource-group"
  location                      = "UK South"
  virtual_network_name          = "my-vnet"
  virtual_network_address_space = ["10.10.0.0/16"]
  
  subnet_front_name             = "frontend-subnet"
  subnet_front_address_prefix   = ["10.10.1.0/24"]
  subnet_front_service_endpoints = ["Microsoft.Storage"]
  
  subnet_back_name              = "backend-subnet"
  subnet_back_address_prefix    = ["10.10.2.0/24"]
  subnet_back_service_endpoints  = ["Microsoft.Storage"]

  tags = {
    Environment = "development"
    ManagedBy   = "Terraform"
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
| [azurerm_virtual_network.cloudnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the virtual network will be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the virtual network will be created. | `string` | n/a | yes |
| <a name="input_subnet_back_address_prefix"></a> [subnet\_back\_address\_prefix](#input\_subnet\_back\_address\_prefix) | The address prefix for the backend subnet (e.g., ["10.0.2.0/24"]). | `list(string)` | n/a | yes |
| <a name="input_subnet_back_name"></a> [subnet\_back\_name](#input\_subnet\_back\_name) | The name of the backend subnet. | `string` | n/a | yes |
| <a name="input_subnet_back_service_endpoints"></a> [subnet\_back\_service\_endpoints](#input\_subnet\_back\_service\_endpoints) | A list of service endpoints to enable on the backend subnet. | `list(string)` | `[]` | no |
| <a name="input_subnet_front_address_prefix"></a> [subnet\_front\_address\_prefix](#input\_subnet\_front\_address\_prefix) | The address prefix for the frontend subnet (e.g., ["10.0.1.0/24"]). | `list(string)` | n/a | yes |
| <a name="input_subnet_front_name"></a> [subnet\_front\_name](#input\_subnet\_front\_name) | The name of the frontend subnet. | `string` | n/a | yes |
| <a name="input_subnet_front_service_endpoints"></a> [subnet\_front\_service\_endpoints](#input\_subnet\_front\_service\_endpoints) | A list of service endpoints to enable on the frontend subnet. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the virtual network. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_address_space"></a> [virtual\_network\_address\_space](#input\_virtual\_network\_address\_space) | The address space for the virtual network (e.g., ["10.0.0.0/16"]). | `list(string)` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the virtual network. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_ids_by_name"></a> [subnet\_ids\_by\_name](#output\_subnet\_ids\_by\_name) | A map of the created subnet names to their IDs. |
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | The ID of the created virtual network. |
<!-- END_TF_DOCS -->