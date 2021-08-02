# 9. Create Amazon Linux server and install/enable httpd

resource "aws_instance" "terraform_course" {

  ami = "ami-0c2b8ca1dad447f8a" # Amazon Linux
  instance_type = "t2.micro"

  tags = {
      
    Name = "web-server"

  }

  availability_zone = "us-east-1a"
  key_name = "terraform-course"

  network_interface {
      device_index = 0 # hard code this as the first network interface on the instance
      network_interface_id = aws_network_interface.terraform_course.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              EOF

}

 output "server_public_ip" {
   value = aws_instance.terraform_course.public_ip

 }