resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = "t2.micro"

  tags = {
    Name = "630_instance_red"
  }
}

data "aws_ami" "this" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_ami_from_instance" "this" {
  name               = "630_ami_red"
  source_instance_id = aws_instance.this.id
  depends_on         = [aws_instance.this]
}