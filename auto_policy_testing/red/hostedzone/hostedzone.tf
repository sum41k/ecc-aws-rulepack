resource "aws_route53_zone" "this" {
  name = "${module.naming.resource_prefix.hostedzone}.com"
}