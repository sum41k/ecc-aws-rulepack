resource "aws_network_interface" "this" {
  subnet_id       = aws_subnet.this.id
  provider        = aws.provider2
}

resource "aws_vpc" "this" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
}

resource "aws_subnet" "this" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.this.names[0]
}
