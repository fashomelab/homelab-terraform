# /labsterraform/modules/storage/variables.tf

variable "resource_group_name" {
  description = "The name of the resource group where resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
}

variable "storage_account_name" {
  description = "The globally unique name of the storage account."
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account. (Standard or Premium.)"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication type of the storage account. (LRS, GRS, ZRS)"
  type        = string
  default     = "LRS"
}

variable "container_names" {
  description = "A list of container names to create within the storage account."
  type        = list(string)
  default     = []
}

variable "network_rules_ip_rules" {
  description = "A list of public IP addresses allowed to access the storage account."
  type        = list(string)
  default     = []
}

variable "virtual_network_subnet_ids" {
  description = "A list of subnet IDs that are allowed to access the storage account."
  type        = list(string)
  default     = []
}

variable "allowed_copy_scope" {
  description = "Restricts the source of server-side copy operations. Valid values are 'AAD' and 'PrivateLink'."
  type        = string
  default     = "AAD"

  validation {
    condition     = contains(["AAD", "PrivateLink"], var.allowed_copy_scope)
    error_message = "The allowed_copy_scope must be either 'AAD' or 'PrivateLink'."
  }
}

variable "tags" {
  description = "A map of tags to apply to the resources."
  type        = map(string)
  default     = {}
}