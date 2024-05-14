output "iam" {
  value = {
    iam-certificate                                               = aws_iam_server_certificate.this.arn,
    iam-group                                                     = aws_iam_group.this.arn,
    iam-role                                                      = aws_iam_role.this.arn,
    iam-user                                                      = aws_iam_user.green.arn,
    ecc-aws-017-credentials_unused_for_45_days                    = [aws_iam_user.green.arn, aws_iam_user.green2.arn],
    ecc-aws-018-iam_users_receive_permissions_only_through_groups = [aws_iam_user.green.arn, aws_iam_user.green2.arn],
    ecc-aws-113-managed_policies_instead_of_inline_iam_policies   = [aws_iam_user.green3.arn, aws_iam_user.green2.arn]
  }
}
