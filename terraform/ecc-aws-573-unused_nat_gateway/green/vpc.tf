resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "573_vpc_green"
  }
}

data "aws_availability_zones" "this" {}

resource "aws_subnet" "private" {
  availability_zone = data.aws_availability_zones.this.names[0]
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.this.id
  tags = {
    "Name" = "573_private_subnet_green"
  }
}

resource "aws_security_group" "this" {
  name   = "573_sg_green"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public.id
  tags = {
    "Name" = "573_nat_gateway_green"
  }
}

resource "aws_subnet" "public" {
  availability_zone = data.aws_availability_zones.this.names[0]
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.this.id
  tags = {
    "Name" = "573_public_subnet_green"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "573_ig_green"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "573_public_route_table_green"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "this" {
  vpc = true
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }
  tags = {
    Name = "573_private_route_table_green"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
