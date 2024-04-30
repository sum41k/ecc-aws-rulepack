data "aws_caller_identity" "this" {}

data "archive_file" "this" {
  type        = "zip"
  source_file = "func.py"
  output_path = "func.zip"
}