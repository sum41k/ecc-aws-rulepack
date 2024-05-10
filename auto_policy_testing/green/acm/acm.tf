resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "this" {
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name  = "${module.naming.resource_prefix.acm}1.com"
    organization = "ACME Examples, Inc"
  }

  validity_period_hours = 800

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "this1" {
  private_key      = tls_private_key.this.private_key_pem
  certificate_body = tls_self_signed_cert.this.cert_pem
}

resource "aws_acm_certificate" "this2" {
  domain_name       = "${module.naming.resource_prefix.acm}2.com"
  validation_method = "DNS"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
  lifecycle {
    create_before_destroy = true
  }
}
