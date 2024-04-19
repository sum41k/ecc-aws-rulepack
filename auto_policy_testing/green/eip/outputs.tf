output "eip" {
  value = {
    elastic-ip = aws_eip.this.allocation_id
  }
}