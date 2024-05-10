output "acm" {
  value = {
    acm-certificate                                                 = aws_acm_certificate.this.arn
    ecc-aws-109-invalid_or_failed_certificates_are_removed_from_acm = data.external.this.result["arn"]
    ecc-aws-393-acm_without_tag_information                         = data.external.this.result["arn"]
  }
}
