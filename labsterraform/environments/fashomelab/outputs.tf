# labsterraform/environments/fashomelab/outputs.tf

output "virtual_machine_details" {
  description = "Details of the deployed Proxmox virtual machines."
  value = {
    for vm_key, vm in module.vmprox : vm_key => {
      name  = vm.vm_name
      vm_id = vm.vm_id
    }
  }
}