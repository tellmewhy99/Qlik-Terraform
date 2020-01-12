resource "azurerm_virtual_network" "qlikview" {
  name                = "Qlik-Main-VN"
  resource_group_name = var.resourcename
  location            = var.resourcelocation
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "appsubnet" {
    name = "QV"
    resource_group_name = var.resourcename
    virtual_network_name = azurerm_virtual_network.qlikview.name
    address_prefix = "10.0.1.0/24"
}

resource "azurerm_subnet" "dbsubnet" {
    name = "db"
    resource_group_name = var.resourcename
    virtual_network_name = azurerm_virtual_network.qlikview.name
    address_prefix = "10.0.2.0/24"
}

resource "azurerm_network_security_group" "qlikview" {
  name                = "QV-NCL"
  location            = var.resourcelocation
  resource_group_name = var.resourcename
  }

resource "azurerm_network_security_rule" "qlikview" {
  name                        = "Web-Server"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80-3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcename
  network_security_group_name = azurerm_network_security_group.qlikview.name
}

resource "azurerm_public_ip" "qvs" {
  name                = "QVS-IP"
  location            = var.resourcelocation
  resource_group_name = var.resourcename
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "qvp" {
  name                = "QVP-IP"
  location            = var.resourcelocation
  resource_group_name = var.resourcename
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "qvsnic" {
  name                = "qvs-nic"
  location            = var.resourcelocation
  resource_group_name = var.resourcename
  network_security_group_id = azurerm_network_security_group.qlikview.id

  ip_configuration {
    name                          = "QVPIP"
    subnet_id                     = azurerm_subnet.appsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.qvs.id
  }
}

resource "azurerm_network_interface" "qvpnic" {
  name                = "qvp-nic"
  location            = var.resourcelocation
  resource_group_name = var.resourcename
  network_security_group_id = azurerm_network_security_group.qlikview.id

  ip_configuration {
    name                          = "QVSIP"
    subnet_id                     = azurerm_subnet.appsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.qvp.id
  }
}

