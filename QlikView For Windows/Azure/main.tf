provider "azurerm" {
}

# Create a resource group
/*resource "azurerm_resource_group" "qlikview" {
  name     = "QlikView"
  location = "North Europe"
}*/

module "initdata" {
  source = "./modules/initdata"

  resourcename = local.resourcename
  resourcelocation = local.resourcelocation

  qvsversion = var.qv == "nov2018" ? local.qvsnov2018 : var.qv == "apr2019" ? local.qvsapr2019 : "none"
  qvpversion = var.qv == "nov2018" ? local.qvpnov2018 : var.qv == "apr2019" ? local.qvpapr2019 : "none"

} 

module "azurevn" {
  source = "./modules/network"

  resourcename = local.resourcename
  resourcelocation = local.resourcelocation
}

module "azurevm" {
  source = "./modules/vm"

  qvsnic = module.azurevn.qvsnic
  qvpnic = module.azurevn.qvpnic
  resourcename = local.resourcename
  resourcelocation = local.resourcelocation

  storagename = module.initdata.storagename
  storagekey = module.initdata.accesskey
  
  qvsversion = var.qv == "nov2018" ? local.qvsnov2018 : var.qv == "apr2019" ? local.qvsapr2019 : "none"
  qvpversion= var.qv == "nov2018" ? local.qvpnov2018 : var.qv == "apr2019" ? local.qvpapr2019 : "none"
  qvsurl = var.qv == "nov2018" ? local.qvsurl: var.qv == "apr2019" ? local.qvsurl : "none"
  qvpurl = var.qv == "nov2018" ? local.qvpurl : var.qv == "apr2019" ? local.qvpurl : "none"

}