resource "aws_security_group" "this" {
  name   = "${module.naming.resource_prefix.lambda_function}"
  vpc_id = data.terraform_remote_state.common.outputs.vpc_id
}

resource "aws_iam_role" "this" {
  name = "${module.naming.resource_prefix.lambda_function}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "this" {
  name = "${module.naming.resource_prefix.lambda_function}"
  role = aws_iam_role.this.id

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeNetworkInterfaces",
                "ec2:CreateNetworkInterface",
                "ec2:DeleteNetworkInterface",
                "ec2:DescribeInstances",
                "ec2:AttachNetworkInterface"
            ],
            "Resource": "*"
        }
    ]
}
  EOF
}

resource "aws_lambda_function" "this" {
  filename                       = "func.zip"
  function_name                  = "${module.naming.resource_prefix.lambda_function}"
  role                           = aws_iam_role.this.arn
  handler                        = "func.py"
  kms_key_arn                    = data.terraform_remote_state.common.outputs.kms_key_arn
  runtime                        = "python3.12"
  reserved_concurrent_executions = 1 
  # Layer version arn:aws:lambda:us-east-1:513731479296:layer:LambdaInsightsExtension:21 does not exist.
  # layers                         = ["arn:aws:lambda:${var.region}:${data.aws_caller_identity.this.account_id}:layer:LambdaInsightsExtension:21"]

  # OR 
  # layers                         = ["data.aws_lambda_layer_version.LambdaInsightsExtension.arn"]

  vpc_config {
    security_group_ids = [aws_security_group.this.id]
    subnet_ids         = [
      data.terraform_remote_state.common.outputs.vpc_subnet_1_id,
      data.terraform_remote_state.common.outputs.vpc_subnet_2_id,
    ]
  }

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      foo = "bar"
    }
  }
}