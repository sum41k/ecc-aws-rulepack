output "kms" {
  value = {
    kms-key                                        = aws_kms_key.this1.arn
    ecc-aws-523-kms_cmk_not_scheduled_for_deletion = aws_kms_key.this2.arn
    ecc-aws-061-kms_key_rotation_is_enabled        = aws_kms_key.this3.arn
  }
}
