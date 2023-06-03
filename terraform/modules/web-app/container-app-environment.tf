resource "azurerm_container_app_environment" "aca_env" {
  name                       = "${var.name}-aca-env"
  location                   = var.resource_group.location
  resource_group_name        = var.resource_group.name
  log_analytics_workspace_id = var.law.id
}