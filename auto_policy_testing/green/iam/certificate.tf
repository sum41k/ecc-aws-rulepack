resource "null_resource" "generate_cert" {
  provisioner "local-exec" {
    command     = "openssl req -x509 -nodes -days 40 -newkey rsa:2048 -keyout private.key -out certificate.crt -subj '/C=US/ST=State/L=City/O=Organization/OU=Department/CN=example.com'"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "rm private.key certificate.crt"
    interpreter = ["/bin/bash", "-c"]
  }
}

data "local_file" "certificate" {
  filename   = "certificate.crt"
  depends_on = [null_resource.generate_cert]
}

data "local_file" "private_key" {
  filename   = "private.key"
  depends_on = [null_resource.generate_cert]
}

resource "aws_iam_server_certificate" "this" {
  name             = module.naming.resource_prefix.iam_cert
  certificate_body = data.local_file.certificate.content
  private_key      = data.local_file.private_key.content
}