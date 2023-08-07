resource "aws_cloudwatch_log_group" "this" {
  name = "099_log_group_red"
}

resource "aws_cloudwatch_log_stream" "this" {
  name           = "099_log_stream_red"
  log_group_name = aws_cloudwatch_log_group.this.name
}