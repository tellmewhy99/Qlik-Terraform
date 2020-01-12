output "adid" {
  value = aws_directory_service_directory.qlikad.name
}

output "dns" {
   value = aws_directory_service_directory.qlikad.dns_ip_addresses
}