# live/av-azure/dev/outputs.tf

output "virtual_machine_details" {
  description = "Details of the deployed virtual machines."
  value = {
    web_server = {
      name      = module.web_vm.vm_name
      public_ip = module.web_vm.public_ip_address
    }
    app_server = {
      name      = module.app_vm.vm_name
      public_ip = module.app_vm.public_ip_address
    }
  }
}

output "storage_account_name" {
  description = "The generated storage account name."
  value       = module.storage.storage_account_name
}

output "database_fqdn" {
  description = "The fully qualified domain name of the PostgreSQL flexible server."
  value       = module.database.fqdn
  sensitive   = true
}