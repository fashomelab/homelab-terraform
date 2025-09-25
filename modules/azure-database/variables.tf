# labsterraform/modules/azure-database/variables.tf

variable "db_name" {
  description = "The name of the PostgreSQL flexible server."
  type        = string
}

variable "location" {
  description = "The Azure region where the database server will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for the database server."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to which the database should be connected for private access."
  type        = string
}

variable "db_admin_login" {
  description = "The administrator login name for the PostgreSQL server."
  type        = string
}

variable "db_admin_password" {
  description = "The administrator password for the PostgreSQL server."
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU Name for the PostgreSQL server. (e.g., B_Standard_B1ms, GP_Standard_D2s_v3)"
  type        = string
  default     = "B_Standard_B1ms" # A small, cost-effective SKU for development.
}

variable "private_dns_zone_name" {
  description = "The ID of a Private DNS Zone to associate with the server. If null, no zone is associated."
  type        = string

}

variable "private_dns_zone_id" {
  description = "The ID of the Private DNS Zone to associate with the server."
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network to link the Private DNS Zone to."
  type        = string
}

variable "db_version" {
  description = "The version of PostgreSQL to use."
  type        = string
  default     = "14"

  validation {
    condition     = contains(["13", "14", "15", "16"], var.db_version)
    error_message = "The db_version must be a valid major version like '13', '14', '15', or '16'."
  }
}

variable "db_storage_mb" {
  description = "The max storage allocation in megabytes. The minimum is 32768 (32GB)."
  type        = number
  default     = 32768

  validation {
    condition     = var.db_storage_mb >= 32768
    error_message = "The db_storage_mb must be at least 32768."
  }
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is enabled for this server."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to apply to the database server."
  type        = map(string)
  default     = {}
}