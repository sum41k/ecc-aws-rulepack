output "app-flow" {
  value = {
    app-flow = aws_appflow_flow.this.arn
  }
}
