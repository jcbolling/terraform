# 1. Create vpc

resource "aws_vpc" "terraform_course" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraform_course"
  }
}

# 2. Create Internet Gateway

resource "aws_internet_gateway" "terraform_course" {
  vpc_id = aws_vpc.terraform_course.id

  tags = {
    Name = "terraform_course"
  }
}

# 3. Create Custom Route Table

resource "aws_route_table" "terraform_course" {
  vpc_id = aws_vpc.terraform_course.id

  route {
    cidr_block = "0.0.0.0/0" # default route sending all traffic from VPC to the internet
    gateway_id = aws_internet_gateway.terraform_course.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.terraform_course.id
  }

  tags = {
    Name = "example"
  }
}

# 4. Create a Subnet

resource "aws_subnet" "terraform_course" {
  vpc_id     = aws_vpc.terraform_course.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Terraform_course"
  }
  availability_zone = "us-east-1a"

}

# 5. Associate subnet with Route Table

resource "aws_route_table_association" "terraform_course" {
  subnet_id      = aws_subnet.terraform_course.id
  route_table_id = aws_route_table.terraform_course.id
}

# 7. Create a network interface with an ip in the subnet that was created in step 4

resource "aws_network_interface" "terraform_course" {
  subnet_id       = aws_subnet.terraform_course.id
  private_ips     = ["10.0.2.50"]
  security_groups = [aws_security_group.terraform_course.id]

}

# 8. Assign an elastic IP to the network interface created in step 7

resource "aws_eip" "terraform_course" {
  network_interface = aws_network_interface.terraform_course.id
  associate_with_private_ip = "10.0.2.50"
  vpc      = true
  depends_on = [aws_internet_gateway.terraform_course]

}