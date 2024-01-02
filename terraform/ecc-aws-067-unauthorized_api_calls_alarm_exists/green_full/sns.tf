resource "aws_sns_topic" "this" {
  name = "067-sns-green"
}

resource "aws_sqs_queue" "this" {
  name = "067-sqs-green"
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.this.arn
}

# uncomment to test email notification

# resource "null_resource" "this" {
#   provisioner "local-exec" {
#     command = join(" ", [
#       "aws sns subscribe",
#       "--topic-arn ${aws_sns_topic.this.arn}",
#       "--protocol email",
#       "--notification-endpoint ${var.test-email}",
#       "--profile ${var.profile}",
#       "--region ${var.default-region}"
      
#       ]
#     )
#   }
# }