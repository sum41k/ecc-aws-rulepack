output "hostedzone" {
  value = {
    hostedzone = aws_route53_zone.this.id
  }
}
