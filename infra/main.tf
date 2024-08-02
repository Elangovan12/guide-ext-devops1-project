# Create Security Group - This is Resource Zero
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-raspi-sg"
  description = "Traffic Only From Raspberry Pi"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["134.238.19.7/32"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "ec2-jenkins-instance-sg"
  }
}
