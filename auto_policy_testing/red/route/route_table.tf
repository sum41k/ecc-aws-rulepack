resource "aws_route_table" "this" {
  vpc_id   = data.terraform_remote_state.common.outputs.vpc_id
  provider = aws.provider2
}