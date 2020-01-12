resource "aws_eip" "qvsip" {
  instance = aws_instance.qlikviewserver.id
  vpc      = true
}

resource "aws_eip" "qvpip" {
  instance = aws_instance.qlikviewpublisher.id
  vpc      = true
}

resource "aws_instance" "qlikviewserver" {
  ami = "ami-02b212aba9eb84405"
  instance_type = "t2.micro"
  key_name = "QLIK"
  monitoring = false
  associate_public_ip_address = true
  subnet_id = var.sub1id
  vpc_security_group_ids = [var.websg]
  user_data = var.qvsinitdata
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = true
  }

  tags = {
    Name = "QVS"
  }

  depends_on = [var.qvad]
}

resource "aws_instance" "qlikviewpublisher" {
  ami = "ami-02b212aba9eb84405"
  instance_type = "t2.micro"
  key_name = "QLIK"
  monitoring = false
  associate_public_ip_address = true
  subnet_id = var.sub1id
  vpc_security_group_ids = [var.websg]
  user_data = var.qvpinitdata
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = true
  }
  tags = {
    Name = "QVP"
  }

  depends_on = [var.qvad]
}
