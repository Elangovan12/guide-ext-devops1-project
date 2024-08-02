# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-south-1"
}

# Ec2 Sevver name
variable "name" {
  description = "Ec2 for General Usage for Cloud Development"
  type        = string
  default     = "ec2-jenkins"
}
