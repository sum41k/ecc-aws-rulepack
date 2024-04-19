resource "aws_ec2_transit_gateway" "this" {
  provider                        = aws.provider2
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  auto_accept_shared_attachments  = "enable"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  provider           = aws.provider2
  subnet_ids         = [data.terraform_remote_state.common.outputs.vpc_subnet_1_id, data.terraform_remote_state.common.outputs.vpc_subnet_2_id]
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = data.terraform_remote_state.common.outputs.vpc_id
}
