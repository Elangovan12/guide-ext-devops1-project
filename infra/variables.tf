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

################################################################################
# Jenkins Application
################################################################################
# Jenkins Ec2 Server name
variable "server_name_jenkins" {
  description = "Ec2 for General Usage for Cloud Development"
  type        = string
}

# AMI ID - Other than Initial Provisioning it will be always from recent Backup AMI
variable "ami_id_jenkins" {
  description = "Backup AMI"
  type        = string
}

# Keypair
variable "key_name" {
  description = "Keypair for SSH into Machine"
  type        = string
}

# Instance Type
variable "instance_type_jenkins" {
  description = "Ec2 Instance Type"
  type        = string
}

################################################################################
# Tomcat Application
################################################################################
# Tomcat Ec2 Server name
variable "server_name_tomcat" {
  description = "Ec2 for General Usage for Cloud Development"
  type        = string
}

# AMI ID - Other than Initial Provisioning it will be always from recent Backup AMI
variable "ami_id_tomcat" {
  description = "Backup AMI"
  type        = string
}

# Instance Type
variable "instance_type_tomcat" {
  description = "Ec2 Instance Type"
  type        = string
}