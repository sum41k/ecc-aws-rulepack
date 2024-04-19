output "dynamodb_table" {
  value = {
    dynamodb-table = aws_dynamodb_table.this.arn
  }
}
