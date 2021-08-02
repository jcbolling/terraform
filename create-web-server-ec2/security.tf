# 6. Create Security Group to allow port 22,80,443

resource "aws_security_group" "terraform_course" {
  name        = "terraform_course"
  description = "Allow port 80, 443, and 22"
  vpc_id      = aws_vpc.terraform_course.id

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
    Name = "allow_all_protocols_outbound"
  }
}