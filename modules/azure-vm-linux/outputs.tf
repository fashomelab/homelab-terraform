# /labsterraform/modules/azure-vm/outputs.tf
output "vm_name" {
  description = "The ID of the created Azure Virtual Machine."
  value       = azurerm_linux_virtual_machine.cloudvm.name
}
output "vm_id" {
  description = "The ID of the created Azure Virtual Machine."
  value       = azurerm_linux_virtual_machine.cloudvm.id
}

output "public_ip_address" {
  description = "The public IP address of the VM, if created."
  value       = var.create_public_ip ? azurerm_public_ip.publicip[0].ip_address : "No Public IP Created"
}