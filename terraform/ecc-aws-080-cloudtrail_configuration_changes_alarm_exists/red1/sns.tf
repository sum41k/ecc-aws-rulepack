resource "aws_sns_topic" "this" {
  name = "080-sns-red1"
}

resource "aws_sqs_queue" "this" {
  name = "080-sqs-red"
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.this.arn
}
