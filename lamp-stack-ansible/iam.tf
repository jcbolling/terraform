resource "aws_iam_instance_profile" "bn_test_profile" {
  name = "bn_test_profile"
  role = aws_iam_role.bn_test_role.name
}

resource "aws_iam_role" "bn_test_role" {
  name = "test_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}