# Create Security Group - This is Resource Zero
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

