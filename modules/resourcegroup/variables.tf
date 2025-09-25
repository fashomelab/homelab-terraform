# labsterraform/modules/resourcegroup/variables.tf

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where resources will be created"
  type        = string
}

variable "tags" {
  description = "The name of the environment used for tagging"
  type        = map(string)
}