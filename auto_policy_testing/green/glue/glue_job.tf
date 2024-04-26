resource "aws_cloudwatch_log_group" "this" {
  name = module.naming.resource_prefix.glue_job
}

resource "aws_glue_job" "this" {
  name     = module.naming.resource_prefix.glue_job
  role_arn = aws_iam_role.this.arn
  # glue_version = "4.0"
  default_arguments = {
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.this.name
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = ""
    "--enable-spark-ui"                  = "true"
    "--enable-auto-scaling"              = "true"
  }
  command {
    script_location = "s3://${aws_s3_bucket.this.bucket}/script"
  }
}
