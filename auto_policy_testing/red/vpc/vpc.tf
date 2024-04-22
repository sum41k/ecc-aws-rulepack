resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/24"
  provider   = aws.provider2
}

resource "aws_security_group" "this" {
  name        = module.naming.resource_prefix.security_group
  description = module.naming.resource_prefix.security_group
}

resource "aws_vpc_endpoint" "this" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Interface"
  provider          = aws.provider2

  security_group_ids = [
    aws_security_group.this.id,
  ]

  depends_on = [aws_security_group.this, aws_vpc.this]
}