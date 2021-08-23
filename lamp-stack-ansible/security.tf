# Author: Josh Bolling
# Module name: lamp-stack-ansible
# Date: 8/13/21

# Create Security Group to allow port 80 and 443

resource "aws_security_group" "bn_test_sg_80_443" {
  name        = "bn_test_sg_80_443"
  description = "Allow port 80 and 443"
  vpc_id      = aws_vpc.bn_test.id

  ingress {
    description      = "SSL"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # this is where you want to allow connections FROM
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # this is where you want to allow connections FROM
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # -1 means any protocol
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bn_test_allow_web_protocols_outbound"
  }
}

# Create Security Group to allow port 22 from the public internet

resource "aws_security_group" "bn_test_sg_22_public" {
  name        = "bn_test_sg_22_public"
  description = "Allow port 22"
  vpc_id      = aws_vpc.bn_test.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # this is where you want to allow connections FROM
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # -1 means any protocol
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bn_test_allow_ssh_inbound"
  }
}

# Create Security Group to allow port 22. Ansible control node

resource "aws_security_group" "bn_test_sg_22_from_bastion_to_private" {
  name        = "bn_test_sg_22_from_bastion_to_private"
  description = "Allow port 22"
  vpc_id      = aws_vpc.bn_test.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.2.0/24"] # this is where you want to allow connections FROM
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # -1 means any protocol
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bn_test_allow_ssh_from_bastion_to_private_subnet"
  }
}

# Create Security Group to allow port 22. Ansible control node

resource "aws_security_group" "bn_test_sg_3306_from_private_to_rds" {
  name        = "bn_test_sg_3306_from_private_to_rds"
  description = "Allow port 3306"
  vpc_id      = aws_vpc.bn_test.id

  ingress {
    description      = "MySQL"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.0.3.0/24"] # this is where you want to allow connections FROM
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # -1 means any protocol
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bn_test_sg_3306_from_private_to_rds"
  }
}