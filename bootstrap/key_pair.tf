resource "aws_key_pair" "proj_key_pair" {
  key_name = "proj-poc-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "proj_tf_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "proj-poc-key"
}