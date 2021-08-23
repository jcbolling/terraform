# Author: Josh Bolling
# Module name: lamp-stack-ansible
# Date: 8/13/21

# Create vpc

resource "aws_vpc" "bn_test" {
  cidr_block       = var.vpc_subnet
  instance_tenancy = "default"

  tags = {
    Name = "BN-TEST"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "bn_test_igw_01" {
  vpc_id = aws_vpc.bn_test.id

  tags = {
    Name = "BN-TEST-IGN-01"
  }
}

# Create Custom Route Table

resource "aws_route_table" "bn_test_rtbl_01" {
  vpc_id = aws_vpc.bn_test.id

  route {
    cidr_block = "0.0.0.0/0" # default route sending all traffic from VPC to the internet
    gateway_id = aws_internet_gateway.bn_test_igw_01.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.bn_test_igw_01.id
  }

  tags = {
    Name = "BN-TEST-RTBL-01"
  }
}

# Create a public Subnet

resource "aws_subnet" "bn_test_public_subnet_01" {
  vpc_id     = aws_vpc.bn_test.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "BN-TEST-PUBLIC-SUBNET-01"
  }
  availability_zone = "us-east-1a"

}

resource "aws_subnet" "bn_test_private_subnet_01" {
  vpc_id     = aws_vpc.bn_test.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "BN-TEST-PRIVATE-SUBNET-01"
  }
  availability_zone = "us-east-1a"

}

# Associate public subnet with Route Table

resource "aws_route_table_association" "bn_test_rta_public" {
  subnet_id      = aws_subnet.bn_test_public_subnet_01.id
  route_table_id = aws_route_table.bn_test_rtbl_01.id
}

# Associate private subnet with Route Table

resource "aws_route_table_association" "bn_test_rta_private" {
  subnet_id      = aws_subnet.bn_test_private_subnet_01.id
  route_table_id = aws_route_table.bn_test_rtbl_01.id
}

# Create a network interface with an ip in the public subnet for bastion host connectivity

resource "aws_network_interface" "bn_test_bastion_host_eni" {
  subnet_id       = aws_subnet.bn_test_public_subnet_01.id
  private_ips     = ["10.0.2.5"]
  security_groups = [aws_security_group.bn_test_sg_22_public.id]

}

# Assign an elastic IP to the network interface

resource "aws_eip" "bn_test_eip" {
  network_interface = aws_network_interface.bn_test_bastion_host_eni.id
  associate_with_private_ip = "10.0.2.5"
  vpc      = true
  depends_on = [aws_internet_gateway.bn_test_igw_01]

}