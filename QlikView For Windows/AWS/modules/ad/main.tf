resource "aws_directory_service_directory" "qlikad" {
  name     = "qlikview.com"
  password = "Password1234!"
  size     = "Small"

  vpc_settings {
    vpc_id     = var.vpcid
    subnet_ids = [var.sub1id, var.sub2id]
  }
}

resource "aws_vpc_dhcp_options" "microsoft-ad-dhcp" {
  domain_name          = aws_directory_service_directory.qlikad.name
  domain_name_servers  =  [tolist(aws_directory_service_directory.qlikad.dns_ip_addresses)[0],"AmazonProvidedDNS"]
  netbios_node_type    = 2
  depends_on = [aws_directory_service_directory.qlikad]
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = var.vpcid
  dhcp_options_id = aws_vpc_dhcp_options.microsoft-ad-dhcp.id
}






