output "apigwv2" {
  value = {
    apigwv2-stage = [
      aws_apigatewayv2_stage.this1.id,
      aws_apigatewayv2_stage.this2.id
    ]
  }
}