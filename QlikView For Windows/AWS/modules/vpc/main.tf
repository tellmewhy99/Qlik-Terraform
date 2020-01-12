resource "aws_vpc" "main_vpc" {
  cidr_block = "192.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "app_subnet"{
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "192.0.1.0/24" 
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "data_subnet"{
  vpc_id = aws_vpc.main_vpc.id      
  cidr_block = "192.0.2.0/24" 
  availability_zone = "us-east-1b"                                                                                                               
}

resource "aws_security_group" "web_server" {
  name        = "Web Server"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }

  ingress {
    from_port       = 3389
    to_port         = 3389
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.0.0.0/16"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }
}

resource "aws_security_group" "database" {
  name        = "WP Database"
  description = "For WP Database"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.web_server.id]
  } 
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "igw_route" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }
}

resource "aws_main_route_table_association" "main_routetable" {
  vpc_id         = aws_vpc.main_vpc.id
  route_table_id = aws_route_table.igw_route.id
}

