# Create EC2 Instance from Pre-Existing AMI
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = "t3.medium"
  key_name               = "vscode-key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = aws_default_subnet.default_az1.id
  iam_instance_profile   = "jenkins-ec2-server-admin-role"

  tags = {
    Name        = var.ec2_server_name
    Terraform   = "true"
    Environment = "dev"
  }
}
