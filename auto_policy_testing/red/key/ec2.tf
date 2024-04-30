resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  provider   = aws.provider2
  key_name   = module.naming.resource_prefix.ec2_instance
  public_key = tls_private_key.this.public_key_openssh
}

