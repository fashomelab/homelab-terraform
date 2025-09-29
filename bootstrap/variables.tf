# bootstrap/variables.tf

variable "company_abbr" {
  description = "A short (3-6 character) abbreviation for the company or project."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,6}$", var.company_abbr))
    error_message = "The company_abbr must be 3 to 6 characters long and contain only lowercase letters and numbers."
  }
}

variable "region_abbr" {
  description = "A short 3-letter lowercase abbreviation for the Azure region (e.g., uks, eus)."
  type        = string

  validation {
    condition     = can(regex("^[a-z]{3}$", var.region_abbr))
    error_message = "The region_abbr must be exactly 3 lowercase letters."
  }
}

variable "location" {
  description = "The Azure region where resources will be created."
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

variable "allow_nested_items_to_be_public" {
  description = "If false, prevents any container in the account from being made public. Recommended to be false for secure backends."
  type        = bool
  default     = false
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

variable "network_rules_ip_rules" {
  description = "A list of public IP addresses allowed to access the storage account."
  type        = list(string)
  default     = []
}

variable "container_names" {
  description = "A list of container names to create within the storage account."
  type        = list(string)
  default     = []
}

variable "container_access_type" {
  description = "The public access level for the storage containers. Can be 'private', 'blob', or 'container'. Recommended to be 'private' for backend state."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "blob", "container"], var.container_access_type)
    error_message = "The container_access_type must be one of 'private', 'blob', or 'container'."
  }
}

variable "common_tags" {
  description = "A map of common tags to apply to all resources."
  type        = map(string)
  default     = {}
}