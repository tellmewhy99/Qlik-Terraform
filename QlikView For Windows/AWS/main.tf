provider "aws" {
  profile    = "qv1"
  region     = "us-east-1"
}

module "awsvpc" {
    source = "./modules/vpc"
}

module "initdata" {
    source = "./modules/initdata"
}

module "awsad" {
    source = "./modules/ad"

    vpcid = module.awsvpc.vpcid
    sub1id = module.awsvpc.sub1id
    sub2id = module.awsvpc.sub2id

    websg = module.awsvpc.websg
} 

module "awsec2" {
    source = "./modules/ec2"

    sub1id = module.awsvpc.sub1id
    websg = module.awsvpc.websg

    qvad = module.awsad.adid
    qvsinitdata = var.qvversion == "nov2018" ? local.qvsnov2018 : var.qvversion == "apr2019" ? local.qvsapr2019 : "none"
    qvpinitdata = var.qvversion == "nov2018" ? local.qvpnov2018 : var.qvversion == "apr2019" ? local.qvpapr2019 : "none"
}

