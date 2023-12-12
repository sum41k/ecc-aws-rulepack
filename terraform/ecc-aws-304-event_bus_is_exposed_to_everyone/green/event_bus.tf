data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "304_event_bus_policy_green"
    effect = "Allow"
    actions = [
      "events:DescribeEventBus",
    ]
    resources = [
      "arn:aws:events:us-east-1:${data.aws_caller_identity.current.account_id}:event-bus/304_event_bus_green"
    ]

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_caller_identity.current.account_id}"]
    }
  }
}

resource "aws_cloudwatch_event_bus_policy" "test" {
  policy         = data.aws_iam_policy_document.this.json
  event_bus_name = aws_cloudwatch_event_bus.this.name
}

resource "aws_cloudwatch_event_bus" "this" {
  name = "304_event_bus_green"
}
