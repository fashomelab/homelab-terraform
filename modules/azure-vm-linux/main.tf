# /labsterraform/modules/azure-vm/main.tf

# Creates a Public IP address for the VM, but only if var.create_public_ip is true.
resource "azurerm_public_ip" "publicip" {
  count               = var.create_public_ip ? 1 : 0
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# A VM needs a Network Interface (NIC) to connect to a network.
resource "azurerm_network_interface" "vmnic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    # Conditionally associate the Public IP only if it was created.
    public_ip_address_id = var.create_public_ip ? azurerm_public_ip.publicip[0].id : null
  }
}

# This is the Linux Virtual Machine itself.
resource "azurerm_linux_virtual_machine" "cloudvm" {
  name                            = var.vm_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.admin_username
  tags                            = var.tags
  disable_password_authentication = true # Best practice for security

  network_interface_ids = [
    azurerm_network_interface.vmnic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key_public
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}