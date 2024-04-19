output "vpc" {
  value = {
    vpc          = data.terraform_remote_state.common.outputs.vpc_id
    vpc-endpoint = aws_vpc_endpoint.this.id
  }
}