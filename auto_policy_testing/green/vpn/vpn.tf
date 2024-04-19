resource "aws_vpn_gateway" "this" {
  vpc_id = data.terraform_remote_state.common.outputs.vpc_id
}