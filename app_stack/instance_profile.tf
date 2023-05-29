resource "aws_iam_role" "proj_role" {
  name = "proj-poc-role"

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

  tags = {
    name = "proj-poc-role"
  }
}

resource "aws_iam_role_policy" "proj_policy" {
  name = "proj-poc-policy"
  role = aws_iam_role.proj_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "proj_instance_profile" {
  name = "proj-poc-instance-profile"
  role = aws_iam_role.proj_role.name
}