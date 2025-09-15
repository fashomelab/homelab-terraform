# /modules/networking/variables.tf

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual network will be created."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "The address space for the virtual network (e.g., [\"10.0.0.0/16\"])."
  type        = list(string)
}

variable "subnets" {
  description = "A map of subnet configurations to create."
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string), [])
    delegation_name   = optional(string)
  }))
  default = {}
}

variable "tags" {
  description = "A map of tags to apply to the virtual network."
  type        = map(string)
  default     = {}
}