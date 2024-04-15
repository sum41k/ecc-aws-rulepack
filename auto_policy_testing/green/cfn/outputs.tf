output "cfn" {
  value = {
    cfn = aws_cloudformation_stack.this.id
  }
}