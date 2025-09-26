# live/av-azure/prod/variables.tf

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

variable "environment" {
  description = "The name of the environment (e.g., dev, staging, prod)."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.environment)) && length(var.environment) <= 6
    error_message = "The environment must contain only lowercase letters and numbers, and be 6 characters or fewer."
  }
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the main resource group for the environment."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "A map of subnet configurations to create for this environment."
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string), [])
    delegation_name   = optional(string)
  }))
}

variable "vm_size" {
  description = "The size of the VM instance"
  type        = string
  default     = "Standard_B1s"
}

variable "create_public_ip" {
  description = "If true, a public IP address will be created and associated with the VM."
  type        = bool
  default     = false
}

variable "image_publisher" {
  description = "The publisher of the source image (e.g., 'Canonical', 'RedHat')."
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "The offer of the source image (e.g., '0001-com-ubuntu-server-jammy', 'RHEL')."
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  description = "The SKU of the source image (e.g., '22_04-lts-gen2')."
  type        = string
  default     = "22_04-lts-gen2"
}

variable "image_version" {
  description = "The version of the source image. Defaults to 'latest'."
  type        = string
  default     = "latest"
}

variable "private_dns_zone_name" {
  description = "The name of the Private DNS Zone."
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

variable "storage_account_name" {
  description = "The globally unique name of the storage account."
  type        = string
}

variable "container_names" {
  description = "The names of the containers to create for this environments storage account"
  type        = list(string)
}

variable "common_tags" {
  description = "A map of common tags to apply to all resources."
  type        = map(string)
  default     = {}
}