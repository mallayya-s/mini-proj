data "aws_ami" "app" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["app-ami-*"]
  }
}

data "template_file" "userdata" {
  template = file("userdata.tpl")
}

data "aws_vpc" "proj_vpc" {
  filter {
    name   = "tag:Name"
    values = ["project-poc"]
  }
}

data "aws_subnet" "sub_1" {
  filter {
    name   = "tag:Name"
    values = ["project-poc-public-subnet-1"]
  }
}

data "aws_subnet" "sub_2" {
  filter {
    name   = "tag:Name"
    values = ["project-poc-public-subnet-2"]
  }
}

data "aws_key_pair" "proj_key" {
  key_name = "proj-poc-key"
  #include_public_key = true
}