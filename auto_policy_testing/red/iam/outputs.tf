output "iam" {
  value = {
    iam-certificate                                      = aws_iam_server_certificate.this.arn,
    iam-group                                            = aws_iam_group.this.arn,
    iam-role                                             = aws_iam_role.this.arn,
    iam-user                                             = aws_iam_user.red1.arn,
    ecc-aws-514-inactive_iam_access_keys_are_not_deleted = aws_iam_user.red2.arn
  }
}
