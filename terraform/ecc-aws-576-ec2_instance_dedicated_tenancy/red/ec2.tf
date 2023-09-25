resource "aws_instance" "this" {
  ami                    = data.aws_ami.this.id
  instance_type          = "a1.medium"
  vpc_security_group_ids = ["${aws_security_group.this.id}"]
  subnet_id              = data.aws_subnets.this.ids[0]
  tenancy                = "dedicated"
  tags = {
    Name = "576_instance_red"
  }
}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "this" {
  name        = "576_sg_red"
  description = "576_sg_red"
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
