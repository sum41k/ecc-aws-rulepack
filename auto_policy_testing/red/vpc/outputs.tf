output "vpc" {
  value = {
    vpc                                       = aws_vpc.this.id
    vpc-endpoint                              = aws_vpc_endpoint.this.id
    ecc-aws-187-ec2_service_use_vpc_endpoints = [aws_vpc.this.id, data.terraform_remote_state.common.outputs.vpc_id]
  }
}