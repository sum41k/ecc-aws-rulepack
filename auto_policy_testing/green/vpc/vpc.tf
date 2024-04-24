resource "aws_flow_log" "this" {
  iam_role_arn    = aws_iam_role.this.arn
  log_destination = aws_cloudwatch_log_group.this.arn
  traffic_type    = "REJECT"
  vpc_id          = data.terraform_remote_state.common.outputs.vpc_id
}

resource "aws_cloudwatch_log_group" "this" {
  name = module.naming.resource_prefix.cw_log_group
}

# 

resource "aws_security_group" "this" {
  name        = module.naming.resource_prefix.security_group
  description = module.naming.resource_prefix.security_group
}

resource "aws_vpc_endpoint" "this" {
  vpc_id            = data.terraform_remote_state.common.outputs.vpc_id
  service_name      = "com.amazonaws.${var.region}.ec2"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.this.id,
  ]

  depends_on = [aws_security_group.this]
}
