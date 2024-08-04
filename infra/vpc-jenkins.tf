################################################################################
# Jenkins VPC Module
################################################################################
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

# Peering Route From Jenkins to Tomcat Private Subnet
resource "aws_route" "jenkins_tomcat_peer_rt" {
  route_table_id         = aws_route_table.public_rt_table.id
  destination_cidr_block = module.application_vpc.private_subnets_cidr_blocks[0]
  gateway_id             = aws_vpc_peering_connection.jenkins_tomcat_peering.id

}

resource "aws_route_table_association" "jenkins_tomcat_peer_rt_assoc" {
  route_table_id = aws_route_table.public_rt_table.id
  subnet_id      = aws_subnet.public_subnet.id
}

################################################################################
# VPC Peering
################################################################################

resource "aws_vpc_peering_connection" "jenkins_tomcat_peering" {
  peer_vpc_id = module.application_vpc.vpc_id
  vpc_id      = aws_vpc.jenkins_vpc.id
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = {
    Name = "Jenkins Tomcat VPC Peering"
  }
}

# Peering Route From Tomcat to Jenkins Private Subnet
resource "aws_route" "tomcat_jenkins_peer_rt" {
  route_table_id         = module.application_vpc.private_route_table_ids[0]
  destination_cidr_block = aws_subnet.public_subnet.cidr_block
  gateway_id             = aws_vpc_peering_connection.jenkins_tomcat_peering.id

}

resource "aws_route_table_association" "tomcat_jenkins_peer_rt_assoc" {
  route_table_id = module.application_vpc.private_route_table_ids[0]
  subnet_id      = module.application_vpc.private_subnets[0]
}