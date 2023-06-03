resource "azurerm_mssql_database" "mssql_database" {
  name      = "${var.name}-mssql-database"
  server_id = var.mssql_server.id

  sku_name     = var.mssql_database_config.sku_name

  min_capacity = var.mssql_database_config.min_size_gb
  max_size_gb  = var.mssql_database_config.max_size_gb

  auto_pause_delay_in_minutes = var.mssql_database_config.auto_pause_delay
  
  storage_account_type = var.mssql_database_config.storage_account_type

  tags = var.tags
}

resource "azurerm_key_vault_secret" "mssql_database_connection_string" {
  name         = "WebAppDatabase"
  value        = "Server=tcp:${var.mssql_server.name}.database.windows.net,1433;Initial Catalog=${azurerm_mssql_database.mssql_database.name};Persist Security Info=False;User ID=${var.mssql_server.administrator_login};Password=${var.mssql_server.administrator_login_password};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = var.key_vault.id
}

