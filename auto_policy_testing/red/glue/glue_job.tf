resource "aws_cloudwatch_log_group" "this" {
  name = module.naming.resource_prefix.glue_job
}

resource "aws_glue_job" "this" {
  provider = aws.provider2
  name     = module.naming.resource_prefix.glue_job
  role_arn = aws_iam_role.this.arn

  glue_version = "3.0"

  command {
    script_location = "s3://${aws_s3_bucket.this.bucket}/script"
  }
}
