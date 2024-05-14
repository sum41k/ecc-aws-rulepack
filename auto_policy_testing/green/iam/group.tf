resource "aws_iam_group" "this" {
  name = module.naming.resource_prefix.iam_group
  path = "/"
}

resource "aws_iam_group_membership" "this" {
  name = module.naming.resource_prefix.iam_group

  users = [
    aws_iam_user.green.name,
  ]

  group = aws_iam_group.this.name
}

resource "aws_iam_policy" "this" {
  name        = module.naming.resource_prefix.iam_policy
  description = "ensure mfa is enabled"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:CreateVirtualMFADevice",
        "iam:ListMFADevices",
        "iam:GetAccountPasswordPolicy",
        "iam:ChangePassword"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_group_policy_attachment" "green" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.this.arn
}
