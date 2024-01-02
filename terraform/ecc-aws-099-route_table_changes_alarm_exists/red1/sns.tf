resource "aws_sns_topic" "this" {
  name = "099-sns-red1"
}

resource "aws_sqs_queue" "this" {
  name = "099-sqs-green"
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.this.arn
}