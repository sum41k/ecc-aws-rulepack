resource "aws_cloudtrail" "this" {
  name                          = "trail-968-green"
  s3_bucket_name                = aws_s3_bucket.this.id
  s3_key_prefix                 = "prefix_968_green"
  include_global_service_events = false

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type = "AWS::S3::Object"
      values = ["${aws_s3_bucket.this.arn}/"]
    }
  }
}