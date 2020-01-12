
data "template_file" "initqvsnov2018SR3" {
  template = file("${path.module}/server/nov2018SR3.txt")
}

data "template_file" "initqvsapr2019SR1" {
  template = file("${path.module}/server/apr2019SR1.txt")
}

data "template_file" "initqvpnov2018SR3" {
  template = file("${path.module}/publisher/nov2018SR3.txt")
}

data "template_file" "initqvpapr2019SR1" {
  template = file("${path.module}/publisher/apr2019SR1.txt")
}

