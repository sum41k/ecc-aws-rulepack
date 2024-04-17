output "transit" {
  value = {
    vpc          = aws_vpc.this.id
    vpc-endpoint = aws_vpc_endpoint.this.id
  }
}