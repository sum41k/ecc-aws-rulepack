data "aws_caller_identity" "this" {}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "Allow root"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root",
      ]
    }
    actions = [
      "kms:*",
    ]
    resources = [
      "*",
    ]
  }
}
