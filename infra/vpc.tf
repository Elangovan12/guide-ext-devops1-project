
resource "aws_vpc" "jenkins_vpc" {
  cidr_block       = "10.100.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "jenkins_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.jenkins_vpc.id
  cidr_block = "10.100.1.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "Main"
  }
}
