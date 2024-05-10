resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 1024
}

resource "tls_self_signed_cert" "this" {
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name = "*.${module.naming.resource_prefix.acm}.com"
  }

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  validity_period_hours = 12
}

resource "aws_acm_certificate" "this" {
  private_key      = tls_private_key.this.private_key_pem
  certificate_body = tls_self_signed_cert.this.cert_pem
}

data "external" "this" {
  program = ["bash", "-c", "aws acm request-certificate --domain-name ${module.naming.resource_prefix.acm}.c1 --validation-method DNS | jq -r -c '{arn: .CertificateArn}'"]
}

resource "null_resource" "this" {
  triggers = {
    cert_arn = data.external.this.result["arn"]
  }
  provisioner "local-exec" {
    when    = destroy
    command = "aws acm delete-certificate --certificate-arn ${self.triggers.cert_arn}"
  }
}