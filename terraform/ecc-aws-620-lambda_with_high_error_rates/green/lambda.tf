data "archive_file" "this" {
  type        = "zip"
  source_file = "func.py"
  output_path = "func.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = "lambda-620-green"
  filename         = data.archive_file.this.output_path
  source_code_hash = data.archive_file.this.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  handler          = "func.lambda_handler"
  runtime          = "python3.9"

  provisioner "local-exec" {
    when    = destroy
    command = "rm func.zip"
  }
}

resource "aws_lambda_invocation" "this1" {
  function_name = aws_lambda_function.this.function_name
  input = jsonencode({})

  depends_on = [ aws_lambda_function.this ]
}

resource "aws_lambda_invocation" "this2" {
  function_name = aws_lambda_function.this.function_name
  input = jsonencode({})

  depends_on = [ aws_lambda_invocation.this1 ]
}

resource "aws_lambda_invocation" "this3" {
  function_name = aws_lambda_function.this.function_name
  input = jsonencode({})

  depends_on = [ aws_lambda_invocation.this2 ]
}