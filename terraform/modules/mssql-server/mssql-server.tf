resource "random_password" "mssql_server_password" {
  length  = 24
  special = true
}

resource "azurerm_key_vault_secret" "mssql_server_credentials" {
  name         = "Sql-Server-Admin-Credentials"
  content_type = "dbAdmin"
  value        = random_password.mssql_server_password.result
  key_vault_id = var.key_vault.id
}

resource "azurerm_mssql_server" "mssql_server" {
  name                = "${var.name}-mssql-server"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  administrator_login          = azurerm_key_vault_secret.mssql_server_credentials.content_type
  administrator_login_password = azurerm_key_vault_secret.mssql_server_credentials.value

  public_network_access_enabled = true

  version             = var.mssql_server_config.version
  minimum_tls_version = var.mssql_server_config.minimum_tls_version

  tags = var.tags
}
