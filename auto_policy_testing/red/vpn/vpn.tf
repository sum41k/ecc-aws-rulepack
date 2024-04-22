resource "aws_vpn_gateway" "this" {
  tags = {
    Name = "${module.naming.resource_prefix.vpn_gtw}"
  }
}