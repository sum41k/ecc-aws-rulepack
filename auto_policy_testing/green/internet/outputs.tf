output "internet" {
  value = {
    internet-gateway = aws_internet_gateway.this.id
  }
}
