# /labsterraform/modules/azure-vm/variables.tf

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "location" {
  description = "The Azure region where the VM will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for the VM."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to which the VM's network interface should be connected."
  type        = string
}

variable "vm_size" {
  description = "The size (SKU) of the virtual machine."
  type        = string
  default     = "Standard_B1s" # A small, cost-effective size
}

variable "admin_username" {
  description = "The admin username for the VM."
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_key_public" {
  description = "The public SSH key for the admin user."
  type        = string
  sensitive   = true
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

variable "tags" {
  description = "A map of tags to apply to all resources in the module."
  type        = map(string)
  default     = {}
}