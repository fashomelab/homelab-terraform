# Terraform Module: Azure Storage Account

This Terraform module provisions a secure Azure Storage Account with a dynamic list of containers.

It is designed to be a reusable component for the [Project FasHomeLab](https://github.com/fashomelab/corneb) infrastructure. The module creates a storage account with network rules to deny public traffic by default, allowing access only from specified IP addresses and virtual network subnets.

---
## Usage Example

Here is a basic example of how to use this module to create a storage account with three containers, locked down to a specific VNet and a single public IP.

```hcl
module "storage" {
  source                     = "./modules/storage"
  
  resource_group_name        = "my-resource-group"
  location                   = "UK South"
  storage_account_name       = "mystorageaccount12345"
  
  container_names = [
    "container-one",
    "container-two",
    "container-three"
  ]

  # Allow access from a specific public IP
  network_rules_ip_rules = ["8.8.8.8"]

  # Allow access from specific subnets
  virtual_network_subnet_ids = [
    module.networking.subnet_ids_by_name["frontend-subnet"],
    module.networking.subnet_ids_by_name["backend-subnet"]
  ]

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
| [azurerm_storage_account.cloudstorageaccount](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.containername](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | The replication type of the storage account. (LRS, GRS, ZRS) | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | The tier of the storage account. (Standard or Premium.) | `string` | `"Standard"` | no |
| <a name="input_allowed_copy_scope"></a> [allowed\_copy\_scope](#input\_allowed\_copy\_scope) | Restricts the source of server-side copy operations. Valid values are 'AAD' and 'PrivateLink'. | `string` | `"AAD"` | no |
| <a name="input_container_names"></a> [container\_names](#input\_container\_names) | A list of container names to create within the storage account. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created. | `string` | n/a | yes |
| <a name="input_network_rules_ip_rules"></a> [network\_rules\_ip\_rules](#input\_network\_rules\_ip\_rules) | A list of public IP addresses allowed to access the storage account. | `list(string)` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where resources will be created. | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The globally unique name of the storage account. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resources. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_subnet_ids"></a> [virtual\_network\_subnet\_ids](#input\_virtual\_network\_subnet\_ids) | A list of subnet IDs that are allowed to access the storage account. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_ids"></a> [container\_ids](#output\_container\_ids) | A map of the created container names to their IDs. |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the created storage account. |
<!-- END_TF_DOCS -->