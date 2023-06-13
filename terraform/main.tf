module "resource_group" {
  source = "./modules/resource-group"

  name     = "cc23-team4-5"
  location = var.location

  tags = {
    class = "Crowd Computing"
    team  = "4&5"
  }
}

module "log_analytics_workspace" {
  source         = "./modules/log-analytics-workspace"
  name           = "cc23-team4-5"
  resource_group = module.resource_group.resource_group
}

module "terraform_state" {
  source = "./modules/terraform-state"

  name = "cc23team45"

  resource_group = module.resource_group.resource_group

  tags = {
    class = "Crowd Computing"
    team  = "4&5"
  }
}

module "keyvault" {
  source = "./modules/keyvault"

  name           = "cc23-team4-5"
  resource_group = module.resource_group.resource_group

  key_vault_config = var.key_vault_config

  tags = {
    class = "Crowd Computing"
    team  = "4&5"
  }

}

module "web_app" {
  source = "./modules/web-app"

  name = "cc23-team4-5"

  resource_group = module.resource_group.resource_group
  key_vault      = module.keyvault.key_vault
  law            = module.log_analytics_workspace.law

  container_app_config         = var.container_app_config
  container_app_extract_config = var.container_app_extract_config
  container_app_produce_config = var.container_app_produce_config
  container_app_verify_config  = var.container_app_verify_config

  tags = {
    class = "Crowd Computing"
    team  = "4&5"
  }

}


module "mssql_server" {
  source = "./modules/mssql-server"

  name = "cc23-team4-5"

  resource_group = module.resource_group.resource_group
  key_vault      = module.keyvault.key_vault

  mssql_server_config = var.mssql_server_config

  tags = {
    class = "Crowd Computing"
    team  = "4&5"
  }
}

module "mssql_database" {
  source = "./modules/mssql-database"

  name = "cc23-team4-5"

  resource_group = module.resource_group.resource_group

  key_vault = module.keyvault.key_vault

  mssql_server          = module.mssql_server.mssql_server
  mssql_database_config = var.mssql_database_config

  tags = {
    class = "Crowd Computing"
    team  = "4&5"
  }
}
