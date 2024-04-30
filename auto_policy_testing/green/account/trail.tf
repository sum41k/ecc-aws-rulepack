resource "aws_cloudtrail" "this1" {
  name                          = "${module.naming.resource_prefix.trail}-1"
  s3_bucket_name                = aws_s3_bucket.this.id
  cloud_watch_logs_role_arn     = aws_iam_role.this.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.this.arn}:*"
  include_global_service_events = true
  is_multi_region_trail         = true

  advanced_event_selector {
    field_selector {
      field  = "eventCategory"
      equals = ["Management"]
    }
  }

  depends_on = [
    aws_s3_bucket.this,
    aws_s3_bucket_policy.this
  ]
}


resource "aws_cloudtrail" "this2" {
  name                          = "${module.naming.resource_prefix.trail}-2"
  s3_bucket_name                = aws_s3_bucket.this.id
  cloud_watch_logs_role_arn     = aws_iam_role.this.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.this2.arn}:*"
  include_global_service_events = true
  is_multi_region_trail         = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }

  depends_on = [
    aws_s3_bucket.this,
    aws_s3_bucket_policy.this
  ]
}
