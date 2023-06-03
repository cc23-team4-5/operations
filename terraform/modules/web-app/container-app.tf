data "azurerm_key_vault_secret" "db_credentials" {
  name = "Sql-Server-Admin-Credentials"
  key_vault_id = var.key_vault.id
}

resource "azurerm_container_app" "web_app" {
  name                         = "${var.name}-web-app"
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  resource_group_name          = var.resource_group.name
  revision_mode                = "Single"

  template {
    min_replicas = var.container_app_config.min_replicas
    max_replicas = var.container_app_config.max_replicas
    container {
      name  = var.container_app_config.web_app.name
      image = var.container_app_config.web_app.image

      cpu    = var.container_app_config.web_app.cpu
      memory = var.container_app_config.web_app.memory

      env {
        name = "CC23_DB_USERNAME"
        value = data.azurerm_key_vault_secret.db_credentials.content_type
      }

      env {
        name = "CC23_DB_PASSWORD"
        value = data.azurerm_key_vault_secret.db_credentials.value
      }

    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8080
    transport                  = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}
