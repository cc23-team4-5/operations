# Create a Storage Account for the Terraform State File
resource "azurerm_storage_account" "terraform_storage_account" {
  name = "${var.name}tfstatesa"

  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  account_kind                     = "StorageV2"
  account_tier                     = "Standard"
  access_tier                      = "Hot"
  account_replication_type         = "ZRS"
  enable_https_traffic_only        = true
  min_tls_version                  = "TLS1_2"
  cross_tenant_replication_enabled = false

  blob_properties {
    versioning_enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  network_rules {
    default_action = "Allow"
  }

  tags = var.tags
}

resource "azurerm_management_lock" "terraform_storage_account_lock" {
  name       = "terraform-storage-account-lock"
  scope      = azurerm_storage_account.terraform_storage_account.id
  lock_level = "CanNotDelete"
  notes      = "Prevent deletion of the storage account holding Terraform State files."
}

resource "azurerm_storage_container" "terraform_container" {
  depends_on           = [azurerm_storage_account.terraform_storage_account]
  name                 = "terraform-state-files"
  storage_account_name = azurerm_storage_account.terraform_storage_account.name
  container_access_type = "private"
}

