output "vpn" {
  value = {
    vpn-gateway = aws_vpn_gateway.this.id
  }
}