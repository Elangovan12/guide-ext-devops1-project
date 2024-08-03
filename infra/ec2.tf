# Create EC2 Instance from Pre-Existing AMI
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  monitoring    = true

  tags = {
    Name        = var.ec2_server_name
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_network_interface" "eni-ec2" {
  subnet_id       = aws_subnet.public_subnet.id
  private_ips      = ["10.100.1.101"]
  security_groups = [aws_security_group.ec2_sg.id]
  attachment {
    instance     = aws_instance.ec2_instance.id
    device_index = 0
  }
  tags = {
    Name = "jenkins_ec2_eni"
  }
}
