# Jenkins EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-jenkins-instance-sg"
  description = "Traffic Only From WorkPC"
  vpc_id      = aws_vpc.jenkins_vpc.id

  tags = {
    "Name" = "ec2-jenkins-instance-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inb_allow_workpc_ipv4" {
  security_group_id = aws_security_group.ec2_sg.id
  ip_protocol       = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_ipv4         = var.workpc_ip
}

resource "aws_vpc_security_group_egress_rule" "outb_allow_internet" {
  security_group_id = aws_security_group.ec2_sg.id
  ip_protocol       = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_ipv4         = "0.0.0.0/0"
}

# Tomcat EC2 Security Group
resource "aws_security_group" "tomcat_sg" {
  name        = "ec2-tomcat-instance-sg"
  description = "Traffic Only From Jenkins Machine"
  vpc_id      = module.application_vpc.vpc_id

  tags = {
    "Name" = "ec2-tomcat-instance-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inb_allow_jenkins_ipv4" {
  security_group_id = aws_security_group.tomcat_sg.id
  ip_protocol       = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_ipv4         = aws_vpc.jenkins_vpc.cidr_block
}

resource "aws_vpc_security_group_egress_rule" "outb_tomcat_allow_internet" {
  security_group_id = aws_security_group.tomcat_sg.id
  ip_protocol       = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_ipv4         = "0.0.0.0/0"
}
