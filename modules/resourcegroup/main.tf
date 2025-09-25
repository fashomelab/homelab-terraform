# labsterraform/modules/resourcegroup/main.tf

resource "azurerm_resource_group" "cloudfas" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}