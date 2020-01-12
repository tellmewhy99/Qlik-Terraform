output "vpcid" {
  value = module.awsvpc.vpcid
}

output "sub1id" {
  value = module.awsvpc.sub1id
}

output "sub2id" {
  value = module.awsvpc.sub2id
}

output "dns" {
  value = module.awsad.dns
}

output "qvsip" {
  value = module.awsec2.qvsip
}

output "qvpip" {
  value = module.awsec2.qvpip
}
