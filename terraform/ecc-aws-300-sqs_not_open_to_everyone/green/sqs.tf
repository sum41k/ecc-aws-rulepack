resource "aws_sqs_queue" "this" {
  name                      = "300_sqs_green"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

data "aws_caller_identity" "current" {}

resource "aws_sqs_queue_policy" "this" {
  queue_url = aws_sqs_queue.this.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "300_sqs_green",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "sqs:*",
      "Resource": "${aws_sqs_queue.this.arn}"
    }
  ]
}
POLICY
}