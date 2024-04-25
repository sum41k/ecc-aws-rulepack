output "glue-security-configuration" {
  value = {
    glue-security-configuration = aws_glue_security_configuration.this.id
  }
}
