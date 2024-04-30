# wrong
resource "aws_sns_topic" "this1" {
  name = "${module.naming.resource_prefix.sns}-1"
}

# correct
resource "aws_sns_topic" "this2" {
  name = "${module.naming.resource_prefix.sns}-2"
}

resource "aws_sqs_queue" "this" {
  name = module.naming.resource_prefix.sqs
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this2.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.this.arn
}

