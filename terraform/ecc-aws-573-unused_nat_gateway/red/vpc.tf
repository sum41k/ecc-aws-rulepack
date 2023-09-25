resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "573_vpc_red"
  }
}

data "aws_availability_zones" "this" {}

resource "aws_subnet" "private" {
  availability_zone = data.aws_availability_zones.this.names[0]
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.this.id
  tags = {
    "Name" = "573_private_subnet_red"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public.id
  tags = {
    "Name" = "573_nat_gateway_red"
  }
}

resource "aws_subnet" "public" {
  availability_zone = data.aws_availability_zones.this.names[0]
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.this.id
  tags = {
    "Name" = "573_public_subnet_red"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "573_ig_red"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "573_public_route_table_red"
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
    Name = "573_private_route_table_red"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
