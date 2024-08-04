# Create Jenkins EC2 Instance
resource "aws_instance" "ec2_instance_jenkins" {
  ami                         = var.ami_id_jenkins
  instance_type               = var.instance_type_jenkins
  key_name                    = var.key_name
  monitoring                  = true
  network_interface {
    network_interface_id = aws_network_interface.eni-ec2.id
    device_index         = 0
  }
  tags = {
    Name        = var.server_name_jenkins
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_eip" "ec2_instance_eip" {
  instance                  = aws_instance.ec2_instance_jenkins.id
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

# Create Apache Tomcat Server EC2 Instance
resource "aws_instance" "ec2_instance_tomcat" {
  ami                         = var.ami_id_tomcat
  instance_type               = var.instance_type_tomcat
  key_name                    = var.key_name
  monitoring                  = true
  network_interface {
    network_interface_id = aws_network_interface.eni_ec2_tomcat.id
    device_index         = 0
  }
  tags = {
    Name        = var.server_name_tomcat
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_network_interface" "eni_ec2_tomcat" {
  subnet_id       = module.application_vpc.private_subnets[0]
  private_ips     = ["10.200.0.101"]
  security_groups = [aws_security_group.tomcat_sg.id]


  tags = {
    Name = "tomcat_ec2_eni"
  }
}