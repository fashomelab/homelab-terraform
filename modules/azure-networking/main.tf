# /modules/networking/main.tf

resource "azurerm_virtual_network" "cloudnet" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.virtual_network_address_space

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name              = subnet.key
      address_prefixes  = subnet.value.address_prefixes
      service_endpoints = subnet.value.service_endpoints

      dynamic "delegation" {
        for_each = subnet.value.delegation_name != null ? [1] : []
        content {
          name = "${subnet.key}-delegation"
          service_delegation {
            name    = subnet.value.delegation_name
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
          }
        }
      }
    }
  }
  tags = var.tags
}