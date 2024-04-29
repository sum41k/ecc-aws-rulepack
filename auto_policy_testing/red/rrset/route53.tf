resource "aws_route53_zone" "this" {
  name = "${module.naming.resource_prefix.hostedzone}.com"
}

resource "aws_route53_record" "this" {
  zone_id        = aws_route53_zone.this.zone_id
  name           = aws_route53_zone.this.name
  type           = "MX"
  set_identifier = module.naming.resource_prefix.r53record
  ttl            = 300
  records        = ["10 mailhost1.example.com"]
  geolocation_routing_policy {
    country = "UA"
  }
}
