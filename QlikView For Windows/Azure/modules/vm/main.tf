resource "azurerm_virtual_machine" "qvs" {
  name                  = "QVS"
  location              = var.resourcelocation
  resource_group_name   = var.resourcename
  network_interface_ids = [var.qvsnic]
  vm_size               = "Standard_B2ms"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "qvsdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
    disk_size_gb      = "200"
  }
  os_profile {
    computer_name  = "qvs"
    admin_username = "qvadmin"
    admin_password = "Password1234!"
  }

  os_profile_windows_config {
      provision_vm_agent = true
      timezone = "GMT Standard Time"


  }
  tags = {
    Name = "QVS"
  }
}

resource "azurerm_virtual_machine" "qvp" {
  name                  = "QVP"
  location              = var.resourcelocation
  resource_group_name   = var.resourcename
  network_interface_ids = [var.qvpnic]
  vm_size               = "Standard_B2ms"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "qvpdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
    disk_size_gb      = "200"
  }
  os_profile {
    computer_name  = "qvp"
    admin_username = "qvadmin"
    admin_password = "Password1234!"
  }

  os_profile_windows_config {
      provision_vm_agent = true
      timezone = "GMT Standard Time"


  }
  tags = {
    Name = "QVP"
  }
}

resource "azurerm_virtual_machine_extension" "qvs" {
  name                  = "qvs"
  location              = var.resourcelocation
  resource_group_name   = var.resourcename
  virtual_machine_name  = azurerm_virtual_machine.qvs.name
  publisher             = "Microsoft.Compute"
  type                  = "CustomScriptExtension"
  type_handler_version  = "1.9"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "fileUris": ["${var.qvsurl}"] 
    }
    SETTINGS
  protected_settings = <<PROTECTED
    {
      "commandToExecute": "${var.qvsversion}.bat",
      "storageAccountName": "${var.storagename}",
      "storageAccountKey": "${var.storagekey}"
    }
    PROTECTED
}

resource "azurerm_virtual_machine_extension" "qvp" {
  name                  = "qvp"
  location              = var.resourcelocation
  resource_group_name   = var.resourcename
  virtual_machine_name  = azurerm_virtual_machine.qvp.name
  publisher             = "Microsoft.Compute"
  type                  = "CustomScriptExtension"
  type_handler_version  = "1.9"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "fileUris": ["${var.qvpurl}"] 
    }
    SETTINGS
  protected_settings = <<PROTECTED
    {
      "commandToExecute": "${var.qvpversion}.bat",
      "storageAccountName": "${var.storagename}",
      "storageAccountKey": "${var.storagekey}"
    }
    PROTECTED
}
