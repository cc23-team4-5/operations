resource "azurerm_key_vault" "key_vault" {
  name = "${var.name}-kvt"

  location            = var.resource_group.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  resource_group_name = var.resource_group.name

  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  sku_name                        = var.key_vault_config.sku

  soft_delete_retention_days = tonumber(var.key_vault_config.soft_delete_retention_days)
  purge_protection_enabled   = tobool(var.key_vault_config.purge_protection)

  tags = var.tags

  network_acls {
    default_action = "Allow"
    bypass = "None"
  }
}