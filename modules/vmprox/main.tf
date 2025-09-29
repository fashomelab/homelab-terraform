# labsterraform/modules/vmprox/main.tf

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  provider = proxmox

  name        = var.vm_name
  description = "Managed by Terraform"
  tags        = var.tags

  node_name = var.node_name
  vm_id     = var.vm_id

  reboot_after_update = false

  # Add the lifecycle block here to ignore specific attributes
  lifecycle {
    ignore_changes = [
      disk[0].size,
      disk[0].file_id,
      cpu[0].architecture,
      initialization
    ]
  }

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    # enabled = false
    enabled = var.guestagent == "true"
    trim    = true
  }
  stop_on_destroy = true

  startup {
    order = "0"
    #up_delay   = "60"
    #down_delay = "60"
  }
  cpu {
    #architecture = "x86_64"
    cores      = var.core_count
    flags      = []
    hotplugged = 0
    limit      = 0
    numa       = false
    sockets    = 1
    type       = "qemu64"
    units      = 1024
  }
  memory {
    dedicated      = var.memory
    floating       = 0
    keep_hugepages = false
    shared         = 0
  }
  disk {
    datastore_id = var.datastore
    file_id      = var.image_file_id
    #file_id      = proxmox_virtual_environment_download_file.focal_server_cloud_img.id
    interface = "scsi0"
    ssd       = true
  }

  initialization {
    # Explicitly use datastore for cloud-init if the provider allows
    datastore_id = var.datastore
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    user_account {
      keys     = var.cloud_init_public_keys
      password = var.vm_password
      username = var.proxmoxuser
    }
  }

  network_device {
    bridge  = var.bridge
    vlan_id = var.vlanid
  }

  operating_system {
    type = "l26"
  }

  tpm_state {
    datastore_id = var.datastore
    version      = "v2.0"
  }

  serial_device {}
}
