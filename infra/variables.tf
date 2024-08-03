# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
}

# MyWorkPC IP
variable "workpc_ip" {
  description = "MyWorkPC IP"
  type        = string
}

# Ec2 Server name
variable "ec2_server_name" {
  description = "Ec2 for General Usage for Cloud Development"
  type        = string
}

# AMI ID - Other than Initial Provisioning it will be always from recent Backup AMI
variable "ami_id" {
  description = "Backup AMI"
  type        = string
}

# Keypair
variable "key_name" {
  description = "Keypair for SSH into Machine"
  type        = string
}

# Instance Type
variable "instance_type" {
  description = "Ec2 Instance Type"
  type        = string
}