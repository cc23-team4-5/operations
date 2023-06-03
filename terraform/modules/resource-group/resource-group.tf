resource "azurerm_resource_group" "resource_group" {
  name     = "${var.name}-rsg"
  location = var.location.full
  tags     = var.tags
}