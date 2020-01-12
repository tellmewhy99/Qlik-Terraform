locals {
    resourcename = "1-5270e4-playground-sandbox"
    resourcelocation = "West US"
    qvsnov2018 = "qvs-nov2018"
    qvsapr2019 = "qvs-apr2019"
    qvpnov2018 = "qvp-nov2018"
    qvpapr2019 = "qvp-apr2019"
    qvsurl     = module.initdata.qvsurl
    qvpurl     = module.initdata.qvpurl
}

variable "qv" {}

