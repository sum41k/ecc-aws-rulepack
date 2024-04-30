resource "aws_internet_gateway" "this" {
  vpc_id = data.terraform_remote_state.common.outputs.vpc_id
  tags = {
    Name = "${module.naming.resource_prefix.internet_gtw}"
  }
}
