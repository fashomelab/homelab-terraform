# labsterraform/modules/vmprox/outputs.tf

output "vm_id" {
  description = "The ID of the created Proxmox VM."
  value       = proxmox_virtual_environment_vm.ubuntu_vm.vm_id
}

output "vm_name" {
  description = "The name of the created Proxmox VM."
  value       = proxmox_virtual_environment_vm.ubuntu_vm.name
}