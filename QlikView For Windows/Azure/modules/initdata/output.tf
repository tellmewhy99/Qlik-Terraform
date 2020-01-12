output "storagename" {
    value = azurerm_storage_account.qlikview.name
}

output "accesskey" {
    value = azurerm_storage_account.qlikview.primary_access_key
}

output "qvsurl" {
    value = azurerm_storage_blob.qvs.url
}

output "qvpurl" {
    value = azurerm_storage_blob.qvp.url
}

output "qvsversion" {
    value = azurerm_storage_blob.qvs.name
}

output "qvpversion" {
    value = azurerm_storage_blob.qvp.name
}