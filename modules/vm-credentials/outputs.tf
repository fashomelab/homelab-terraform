# labsterraform/modules/vm-credentials/outputs.tf
output "password" {
  description = "The generated random password for the VM user."
  value       = random_password.vm_password.result
  sensitive   = true
}

output "public_key_openssh" {
  description = "The generated public key for cloud-init."
  value       = tls_private_key.vm_key.public_key_openssh
}