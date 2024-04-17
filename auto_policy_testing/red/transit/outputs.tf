output "transit" {
  value = {
    transit-gateway    = aws_ec2_transit_gateway.this.arn
    transit-attachment = aws_ec2_transit_gateway_vpc_attachment.this.id
  }
}