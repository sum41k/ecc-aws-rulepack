resource "aws_instance" "ami" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"

  tags = {
    Name = "630_instance_green_ami"
  }
}

data "aws_ami" "ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_ami_from_instance" "this" {
  name               = "630_ami_green"
  source_instance_id = aws_instance.ami.id
}


resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = "t2.micro"

  tags = {
    Name = "630_instance_green"
  }
}

data "aws_ami" "this" {
  most_recent = true
  owners = ["self"]
  filter {
    name = "name"
    values = ["630_ami_green"]
  }
  depends_on = [aws_ami_from_instance.this]
}