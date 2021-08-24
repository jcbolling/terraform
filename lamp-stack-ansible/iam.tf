resource "aws_iam_instance_profile" "bn_test_profile" {
  name = "test_profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
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

resource "aws_iam_role_policy_attachment" "ec2-to-rds-role-policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}