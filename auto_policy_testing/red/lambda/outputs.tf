output "lambda" {
  value = {
    lambda = aws_lambda_function.this.arn
  }
}
