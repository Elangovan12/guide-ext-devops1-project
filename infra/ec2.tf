# Create EC2 Instance from Pre-Existing AMI
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name        = var.ec2_server_name
    Terraform   = "true"
    Environment = "dev"
  }
}
