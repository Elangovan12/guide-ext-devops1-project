# Create EC2 Instance from Pre-Existing AMI
resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  monitoring                  = true
  network_interface {
    network_interface_id = aws_network_interface.eni-ec2.id
    device_index         = 0
  }
  tags = {
    Name        = var.ec2_server_name
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_eip" "ec2_instance_eip" {
  instance                  = aws_instance.ec2_instance.id
  domain                    = "vpc"
  associate_with_private_ip = "10.100.1.101"
  depends_on                = [aws_internet_gateway.jenkins-igw]
}


resource "aws_network_interface" "eni-ec2" {
  subnet_id       = aws_subnet.public_subnet.id
  private_ips     = ["10.100.1.101"]
  security_groups = [aws_security_group.ec2_sg.id]


  tags = {
    Name = "jenkins_ec2_eni"
  }
}
