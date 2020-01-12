resource "azurerm_storage_account" "qlikview" {
  name                     = "qlikviewterraform1001"
  resource_group_name      = var.resourcename
  location                 = var.resourcelocation
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  tags = {
    environment = "QlikView"
  }
}

resource "azurerm_storage_container" "qlikview" {
  name                  = "qvscript"
  storage_account_name  = azurerm_storage_account.qlikview.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "qvs" {
  name                   = "${var.qvsversion}.bat"
  storage_account_name   = azurerm_storage_account.qlikview.name
  storage_container_name = azurerm_storage_container.qlikview.name
  type                   = "Block"
  source                 = "${path.module}/server/${var.qvsversion}.bat"
}

resource "azurerm_storage_blob" "qvp" {
  name                   = "${var.qvpversion}.bat"
  storage_account_name   = azurerm_storage_account.qlikview.name
  storage_container_name = azurerm_storage_container.qlikview.name
  type                   = "Block"
  source                 = "${path.module}/publisher/${var.qvpversion}.bat"
}

