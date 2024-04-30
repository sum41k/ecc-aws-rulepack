data "aws_caller_identity" "this" {}

# data "aws_lambda_layer_version" "LambdaInsightsExtension" {
#   layer_name              = "AWSLambdaInsightsExtension"
#   compatible_architectures = ["x86_64"]
#   compatible_runtimes     = ["python3.12"]
# }