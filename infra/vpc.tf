
resource "aws_vpc" "jenkins_vpc" {
  cidr_block           = "10.100.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "jenkins_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.jenkins_vpc.id
  cidr_block        = "10.100.1.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_internet_gateway" "jenkins-igw" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Name = "jenkins-igw"
  }
}

resource "aws_route_table" "public_rt_table" {
  vpc_id = aws_vpc.jenkins_vpc.id
  tags = {
    Name = "public_rt_table"
  }
}

resource "aws_route" "public_rt" {
  route_table_id         = aws_route_table.public_rt_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.jenkins-igw.id

}

resource "aws_route_table_association" "public_rt_association" {
  route_table_id = aws_route_table.public_rt_table.id
  subnet_id      = aws_subnet.public_subnet.id
}
