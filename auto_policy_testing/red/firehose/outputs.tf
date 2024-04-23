output "firehose" {
  value = {
    firehose = aws_kinesis_firehose_delivery_stream.this.arn
  }
}
