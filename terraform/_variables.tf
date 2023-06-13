variable "location" {
  description = "Map with location of resources"
  default = {
    full  = "westeurope"
    short = "weu"
  }
}

variable "key_vault_config" {
  description = "Map with key vault configuration"
  default = {
    sku                        = "standard"
    purge_protection           = false
    soft_delete_retention_days = 7
  }
}

variable "container_app_config" {
  description = "Map with container instance web app configuration"
  default = {
    max_replicas = 2
    min_replicas = 1
    web_app = {
      cpu    = 1
      memory = "2Gi"
    }
  }
}

variable "container_app_extract_config" {
  default = {
    name  = "web-app-extract"
    image = "ghcr.io/cc23-team4-5/web-app:0.0.14"
  }
}
variable "container_app_produce_config" {
  default = { 
    name = "web-app-produce"
    image = "ghcr.io/cc23-team4-5/web-app:0.0.14" 
  }
}
variable "container_app_verify_config" {
  default = { 
    name = "web-app-verify"
    image = "ghcr.io/cc23-team4-5/web-app:0.0.14" 
  }
}


variable "mssql_server_config" {
  description = "Map with sql server configuration"
  default = {
    version             = "12.0"
    minimum_tls_version = "1.2"
  }
}

variable "mssql_database_config" {
  default = {
    sku_name             = "GP_S_Gen5_4"
    min_size_gb          = "1"
    max_size_gb          = "10"
    auto_pause_delay     = 60
    storage_account_type = "Local"
  }
}
