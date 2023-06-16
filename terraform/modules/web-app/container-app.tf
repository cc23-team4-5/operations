data "azurerm_key_vault_secret" "db_credentials" {
  name         = "Sql-Server-Admin-Credentials"
  key_vault_id = var.key_vault.id
}

resource "azurerm_container_app" "web_app_extract" {
  name                         = "${var.name}-web-app-extract"
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  resource_group_name          = var.resource_group.name
  revision_mode                = "Single"

  template {
    min_replicas = var.container_app_config.min_replicas
    max_replicas = var.container_app_config.max_replicas
    container {
      name  = var.container_app_extract_config.name
      image = var.container_app_extract_config.image

      cpu    = var.container_app_config.web_app.cpu
      memory = var.container_app_config.web_app.memory

      env {
        name  = "CC23_DB_USERNAME"
        value = data.azurerm_key_vault_secret.db_credentials.content_type
      }

      env {
        name  = "CC23_DB_PASSWORD"
        value = data.azurerm_key_vault_secret.db_credentials.value
      }

      env {
        name  = "EXPERIMENT_TASK_NAME"
        value = var.container_app_extract_config.experiment_task_name
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

  lifecycle {
    ignore_changes = [
      ingress.custom_domain
    ]
  }

}

resource "azurerm_container_app" "web_app_produce" {
  name                         = "${var.name}-web-app-produce"
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  resource_group_name          = var.resource_group.name
  revision_mode                = "Single"

  template {
    min_replicas = var.container_app_config.min_replicas
    max_replicas = var.container_app_config.max_replicas
    container {
      name  = var.container_app_produce_config.name
      image = var.container_app_produce_config.image

      cpu    = var.container_app_config.web_app.cpu
      memory = var.container_app_config.web_app.memory

      env {
        name  = "CC23_DB_USERNAME"
        value = data.azurerm_key_vault_secret.db_credentials.content_type
      }

      env {
        name  = "CC23_DB_PASSWORD"
        value = data.azurerm_key_vault_secret.db_credentials.value
      }

      env {
        name  = "EXPERIMENT_TASK_NAME"
        value = var.container_app_produce_config.experiment_task_name
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

  lifecycle {
    ignore_changes = [
      ingress.custom_domain
    ]
  }

}

resource "azurerm_container_app" "web_app_verify" {
  name                         = "${var.name}-web-app-verify"
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  resource_group_name          = var.resource_group.name
  revision_mode                = "Single"

  template {
    min_replicas = var.container_app_config.min_replicas
    max_replicas = var.container_app_config.max_replicas
    container {
      name  = var.container_app_verify_config.name
      image = var.container_app_verify_config.image

      cpu    = var.container_app_config.web_app.cpu
      memory = var.container_app_config.web_app.memory

      env {
        name  = "CC23_DB_USERNAME"
        value = data.azurerm_key_vault_secret.db_credentials.content_type
      }

      env {
        name  = "CC23_DB_PASSWORD"
        value = data.azurerm_key_vault_secret.db_credentials.value
      }

      env {
        name  = "EXPERIMENT_TASK_NAME"
        value = var.container_app_verify_config.experiment_task_name
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

  lifecycle {
    ignore_changes = [
      ingress.custom_domain
    ]
  }

}
