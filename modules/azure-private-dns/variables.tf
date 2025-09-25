# labsterraform/modules/azure-private-dns/variables.tf

variable "private_dns_zone_name" {
  description = "The name of the Private DNS Zone."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create the zone in."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the DNS zone."
  type        = map(string)
}