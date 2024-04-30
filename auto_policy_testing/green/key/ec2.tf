resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.this.key_name

  provisioner "local-exec" {
    command = "aws ec2 stop-instances --instance-ids ${aws_instance.this.id}"
  }

  tags = {
    Name = "${module.naming.resource_prefix.ec2_instance}"
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "this" {
  key_name   = module.naming.resource_prefix.ec2_instance
  public_key = tls_private_key.this.public_key_openssh
}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
