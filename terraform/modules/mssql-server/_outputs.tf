output "mssql_server" {
  value = azurerm_mssql_server.mssql_server
}

output "mssql_server_credentials" {
  value = azurerm_key_vault_secret.mssql_server_credentials
}