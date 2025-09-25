# labsterraform/modules/vmprox/variables.tf

variable "virtual_environment_endpoint" {
  description = "Endpoint of proxmox nodes (URL - https://ipaddress:8006/)"
  type        = string
}

variable "api_token" {
  description = "API token used for authenticating to proxmox node"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string

}

variable "vm_id" {
  description = "ID to use for the VM - these need to be globally unique within your promox cluster/node"
  type        = number

}

variable "bridge" {
  description = "proxmox vmbrX to use"
  type        = string
}

variable "vlanid" {
  description = "vlan id to use"
  type        = number
}

variable "node_name" {
  description = "Name of proxmox host to deploy to"
  type        = string
}

variable "core_count" {
  description = "Number of cores to assign to VM"
  type        = number
}

variable "memory" {
  description = "Amount of RAM to assign to VM"
  type        = number
}

variable "datastore" {
  description = "Where to store datadisk - local-lvm or vm-disks"
  type        = string
}

variable "guestagent" {
  description = "Enable guest agent only after creation"
  type        = string
}

variable "image_file_id" {
  description = "ID of the downloaded image file to use for VM"
  type        = string

}

variable "proxmoxuser" {
  type        = string
  description = "Proxmox user for SSH connections."
  default     = "fasautomation"

}

variable "vm_password" {
  description = "The initial password for the VM user account."
  type        = string
  sensitive   = true
}

variable "cloud_init_public_keys" {
  description = "A list of SSH public keys to inject via cloud-init."
  type        = list(string)
}

variable "tags" {
  description = "Tags for the Proxmox VM"
  type        = list(string)
  default     = ["terraform"]
}
