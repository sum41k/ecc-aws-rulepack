output "acm" {
  value = {
    acm-certificate                                          = aws_acm_certificate.this1.arn
    ecc-aws-528-acm_certificate_transparency_logging_enabled = aws_acm_certificate.this2.arn
  }
}
