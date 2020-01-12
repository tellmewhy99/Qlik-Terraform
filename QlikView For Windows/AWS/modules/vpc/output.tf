output "vpcid" {
  value = aws_vpc.main_vpc.id
}

output "sub1id" {
  value = aws_subnet.app_subnet.id
}

output "sub2id" {
  value = aws_subnet.data_subnet.id
}

output "websg" {
  value = aws_security_group.web_server.id
}