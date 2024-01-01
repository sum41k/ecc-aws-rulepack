resource "aws_sns_topic" "this" {
  name = "096-sns-red1"
}

resource "aws_sqs_queue" "this" {
  name = "096-sqs-red"
}