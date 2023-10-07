resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

data "aws_availability_zones" "this" {
  state = "available"
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.this.names[0]
  map_public_ip_on_launch = false
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = data.aws_availability_zones.this.names[1]
  map_public_ip_on_launch = false
}

resource "aws_security_group" "this" {
  name   = "869_security_group_green"
  vpc_id = aws_vpc.this.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }
}
