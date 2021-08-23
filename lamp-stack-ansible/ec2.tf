resource "aws_instance" "bn_test_bastion_host" {

  ami = "ami-0c2b8ca1dad447f8a" # Amazon Linux
  instance_type = "t2.micro"

  tags = {
      
    Name = "bastion-host"

  }

  availability_zone = "us-east-1a"
  key_name = "terraform-course"

  network_interface {
      device_index = 0 # hard code this as the first network interface on the instance
      network_interface_id = aws_network_interface.bn_test_bastion_host_eni.id
  }

}

resource "aws_instance" "bn_test_ansible_control_host" {

  ami = "ami-0c2b8ca1dad447f8a" # Amazon Linux
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.bn_test_profile.name
  user_data = "${file("post-instance-creation.sh")}"

  tags = {
      
    Name = "ansible_control_host"

  }

  availability_zone = "us-east-1a"
  security_groups = [aws_security_group.bn_test_sg_22_from_bastion_to_private.id]
  subnet_id = aws_subnet.bn_test_private_subnet_01.id
  key_name = "terraform-course"

}

resource "aws_instance" "bn_test_web_server_01" {

  ami = "ami-0c2b8ca1dad447f8a" # Amazon Linux
  instance_type = "t2.micro"

  tags = {
      
    Name = "web-server-01"

  }

  availability_zone = "us-east-1a"
  security_groups = [aws_security_group.bn_test_sg_22_from_bastion_to_private.id]
  subnet_id = aws_subnet.bn_test_private_subnet_01.id
  key_name = "terraform-course"

}